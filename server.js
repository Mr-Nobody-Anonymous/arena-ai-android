/**
 * Arena.ai Optional Local Development Reverse Proxy
 * 
 * Note: The native Android mobile client connects directly to https://arena.ai
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

app.get('/api/network-info', async (req, res) => {
  try {
    const mobileUrl = `http://${HOST}:${PORT}`;
    const qrDataUrl = await QRCode.toDataURL(mobileUrl, {
      errorCorrectionLevel: 'M',
      margin: 2,
      width: 300,
      color: { dark: '#000000', light: '#ffffff' }
    });

    res.json({
      port: PORT,
      primaryIp: HOST,
      primaryInterface: 'Local',
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
  console.log('================================================================');
  console.log('  ARENA.AI LOCAL DEVELOPMENT PROXY ACTIVE                       ');
  console.log('================================================================');
  console.log(`  Local URL:        http://${HOST}:${PORT}`);
  console.log('  Target:           https://arena.ai');
  console.log('  Note:             The Android APK connects directly to Arena  ');
  console.log('                    and does not require this development proxy.');
  console.log('================================================================');
});

module.exports = { app, server };
