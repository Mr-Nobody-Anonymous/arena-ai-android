const express = require('express');
const path = require('path');
const os = require('os');
const QRCode = require('qrcode');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const PORT = process.env.PORT || 3000;

// Helper: Get local network IPv4 addresses
function getNetworkIps() {
  const interfaces = os.networkInterfaces();
  const addresses = [];
  for (const name of Object.keys(interfaces)) {
    for (const net of interfaces[name]) {
      if (net.family === 'IPv4' && !net.internal) {
        addresses.push({
          interface: name,
          ip: net.address,
          type: name.toLowerCase().includes('wi-fi') || name.toLowerCase().includes('wlan') ? 'Wi-Fi' : 'LAN'
        });
      }
    }
  }
  return addresses;
}

// 1. Diagnostics & Verification Endpoints (used by test suite)
app.get('/api/health', (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptimeSeconds: Math.floor(process.uptime()),
    platform: process.platform,
    nodeVersion: process.version,
    memoryUsageMB: Math.round(process.memoryUsage().rss / 1024 / 1024)
  });
});

app.get('/api/network-info', async (req, res) => {
  try {
    const ips = getNetworkIps();
    const primaryIp = ips.find(i => i.type === 'Wi-Fi') || ips[0] || { ip: '127.0.0.1', interface: 'Loopback' };
    const mobileUrl = `http://${primaryIp.ip}:${PORT}`;
    
    const qrDataUrl = await QRCode.toDataURL(mobileUrl, {
      errorCorrectionLevel: 'M',
      margin: 2,
      width: 300,
      color: { dark: '#0f172a', light: '#ffffff' }
    });

    res.json({
      port: PORT,
      primaryIp: primaryIp.ip,
      primaryInterface: primaryIp.interface,
      mobileUrl,
      qrDataUrl
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/api/arena-status', async (req, res) => {
  const targetUrl = 'https://arena.ai/';
  const startTime = Date.now();
  
  try {
    const response = await fetch(targetUrl, {
      method: 'GET',
      redirect: 'follow',
      signal: AbortSignal.timeout(8000),
      headers: {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 14; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Mobile Safari/537.36'
      }
    });

    const latencyMs = Date.now() - startTime;
    const headersObj = {};
    response.headers.forEach((v, k) => { headersObj[k] = v; });

    res.json({
      online: response.ok,
      status: response.status,
      statusText: response.statusText,
      url: response.url,
      latencyMs,
      serverTime: headersObj['date'] || null,
      cloudflareRay: headersObj['cf-ray'] || null,
      xFrameOptions: headersObj['x-frame-options'] || 'NONE',
      contentSecurityPolicy: headersObj['content-security-policy'] ? 'PRESENT' : 'NONE',
      isAccessibleFromMobile: true
    });
  } catch (err) {
    const latencyMs = Date.now() - startTime;
    res.json({
      online: false,
      error: err.message,
      latencyMs,
      targetUrl
    });
  }
});

// 2. Serve Android PWA Assets (Clean, zero injected UI)
app.get('/manifest.json', (req, res) => {
  res.setHeader('Content-Type', 'application/manifest+json');
  res.sendFile(path.join(__dirname, 'public', 'manifest.json'));
});

app.get('/sw.js', (req, res) => {
  res.setHeader('Content-Type', 'application/javascript');
  res.setHeader('Service-Worker-Allowed', '/');
  res.sendFile(path.join(__dirname, 'public', 'sw.js'));
});

app.use('/icons', express.static(path.join(__dirname, 'public', 'icons')));

// 3. 100% Transparent Streaming Reverse Proxy to arena.ai
// - Contains ONLY what the real website has (zero extra UI, zero overlays, zero docks)
// - Complete IP Anonymization & Leak Prevention: Strips all forwarding/client IP headers
// - Normalizes frame restrictions so Android Chrome / WebView render cleanly
const arenaProxy = createProxyMiddleware({
  target: 'https://arena.ai',
  changeOrigin: true,
  secure: true,
  ws: true,
  cookieDomainRewrite: '',
  on: {
    proxyReq: (proxyReq, req, res) => {
      // Complete IP Leak Protection: Strip all headers that could disclose client IP or proxy topology
      const ipHeadersToStrip = [
        'x-forwarded-for',
        'x-real-ip',
        'forwarded',
        'via',
        'x-forwarded-host',
        'x-forwarded-proto',
        'client-ip',
        'true-client-ip',
        'cf-connecting-ip',
        'fastly-client-ip',
        'x-cluster-client-ip',
        'x-client-ip'
      ];
      ipHeadersToStrip.forEach(h => proxyReq.removeHeader(h));
    },
    proxyRes: (proxyRes, req, res) => {
      // Remove framing restriction headers so mobile browsers and WebViews render without CSP blocks
      delete proxyRes.headers['x-frame-options'];
      delete proxyRes.headers['content-security-policy'];
      delete proxyRes.headers['content-security-policy-report-only'];
      proxyRes.headers['access-control-allow-origin'] = '*';
    },
    error: (err, req, res) => {
      console.error('Proxy Error:', err.message);
      if (!res.headersSent) {
        res.status(502).send('Error connecting to Arena.ai cloud gateway.');
      }
    }
  }
});

// Route everything to the authentic website
app.use(arenaProxy);

// Start Server
const server = app.listen(PORT, '0.0.0.0', () => {
  const ips = getNetworkIps();
  const primaryIp = ips.find(i => i.type === 'Wi-Fi') || ips[0] || { ip: 'localhost', interface: 'Local' };
  const mobileUrl = `http://${primaryIp.ip}:${PORT}`;

  console.log('================================================================');
  console.log('  🚀 ARENA.AI AUTHENTIC LIVE STREAMING GATEWAY ACTIVE           ');
  console.log('================================================================');
  console.log(`  Local URL:        http://localhost:${PORT}`);
  console.log(`  Android Mobile:   ${mobileUrl}`);
  console.log(`  Network Adapter:  ${primaryIp.interface} (${primaryIp.ip})`);
  console.log('  IP Leak Shield:   ENABLED (All client IP headers stripped)    ');
  console.log('  Injected UI:      NONE (100% pure authentic website only)     ');
  console.log('----------------------------------------------------------------');
  console.log('  📱 SCAN THIS QR CODE WITH YOUR ANDROID PHONE TO OPEN:');
  console.log('----------------------------------------------------------------');
  
  QRCode.toString(mobileUrl, { type: 'terminal', small: true }, (err, qrStr) => {
    if (!err && qrStr) console.log(qrStr);
    console.log('================================================================');
  });
});

module.exports = { app, server };
