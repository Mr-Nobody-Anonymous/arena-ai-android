/**
 * Arena.ai Optional Local Development Reverse Proxy
 *
 * Note: the native Android mobile client connects directly to https://arena.ai
 * and does NOT require this local proxy server.
 * This proxy is provided solely as an optional development utility for inspecting
 * web traffic, headers, and upstream responses from a desktop environment.
 */

const express = require('express');
const os = require('os');
const QRCode = require('qrcode');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const PORT = process.env.PORT || 3000;
const HOST = process.env.HOST || '127.0.0.1';
const pkg = require('./package.json');

/**
 * Picks the address a phone on the same network can actually reach.
 * `0.0.0.0` and `127.0.0.1` are bind addresses, never usable in a QR code.
 */
function findLanAddress(bindHost) {
  const candidates = [];
  const interfaces = os.networkInterfaces();
  for (const [name, addresses] of Object.entries(interfaces)) {
    for (const address of addresses || []) {
      if (address.family === 'IPv4' && !address.internal) {
        candidates.push({ name, address: address.address });
      }
    }
  }

  if (bindHost && bindHost !== '0.0.0.0' && bindHost !== '127.0.0.1' && bindHost !== 'localhost') {
    const exact = candidates.find((candidate) => candidate.address === bindHost);
    if (exact) {
      return exact;
    }
  }

  const preferred = candidates.find((candidate) => candidate.address.startsWith('192.168.'))
    || candidates.find((candidate) => candidate.address.startsWith('10.'))
    || candidates.find((candidate) => /^172\.(1[6-9]|2\d|3[01])\./.test(candidate.address))
    || candidates[0];

  return preferred || { name: 'Loopback', address: '127.0.0.1' };
}

// 1. Diagnostics & Health Endpoints
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

app.get('/api/version', (req, res) => {
  res.json({
    name: pkg.name,
    version: pkg.version,
    node: process.version
  });
});

app.get('/api/network-info', async (req, res) => {
  try {
    const primary = findLanAddress(HOST);
    const mobileUrl = `http://${primary.address}:${PORT}`;
    const qrDataUrl = await QRCode.toDataURL(mobileUrl, {
      errorCorrectionLevel: 'M',
      margin: 2,
      width: 300,
      color: { dark: '#000000', light: '#ffffff' }
    });

    res.json({
      port: PORT,
      bindHost: HOST,
      primaryIp: primary.address,
      primaryInterface: primary.name,
      mobileUrl,
      reachableFromLan: HOST === '0.0.0.0' || HOST === '::',
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
      contentSecurityPolicy: headersObj['content-security-policy'] ? 'PRESENT' : 'NONE'
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

// 2. Transparent Streaming Reverse Proxy to arena.ai for development inspection
const arenaProxy = createProxyMiddleware({
  target: 'https://arena.ai',
  changeOrigin: true,
  secure: true,
  ws: true,
  cookieDomainRewrite: '',
  on: {
    proxyReq: (proxyReq, req, res) => {
      // Optional header cleanup during dev proxying
      const headersToStrip = [
        'x-forwarded-for',
        'x-real-ip',
        'forwarded',
        'via'
      ];
      headersToStrip.forEach(h => proxyReq.removeHeader(h));
    },
    error: (err, req, res) => {
      console.error('Proxy Error:', err.message);
      if (!res.headersSent) {
        res.status(502).send('Error connecting to Arena.ai.');
      }
    }
  }
});

app.use(arenaProxy);

// Start Server bound to loopback by default for security
const server = app.listen(PORT, HOST, () => {
  const lan = findLanAddress(HOST);
  console.log('================================================================');
  console.log('  ARENA.AI LOCAL DEVELOPMENT PROXY ACTIVE                       ');
  console.log('================================================================');
  console.log(`  Local URL:        http://${HOST}:${PORT}`);
  console.log(`  LAN URL:          http://${lan.address}:${PORT} (${lan.name})`);
  console.log('  Target:           https://arena.ai');
  console.log('  Note:             The Android APK connects directly to Arena  ');
  console.log('                    and does not require this development proxy.');
  if (HOST === '127.0.0.1' || HOST === 'localhost') {
    console.log('  Tip:              Set HOST=0.0.0.0 to make the LAN URL/QR   ');
    console.log('                    reachable from a phone on the same network.');
  }
  console.log('================================================================');
});

module.exports = { app, server, findLanAddress };
