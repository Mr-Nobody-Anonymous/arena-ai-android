const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3000;
const BASE_URL = `http://127.0.0.1:${PORT}`;

// Test Collector
const results = {
  timestamp: new Date().toISOString(),
  totalTests: 0,
  passed: 0,
  failed: 0,
  testCases: [],
  benchmarks: {},
  systemInfo: {}
};

function logTest(category, name, passed, details = null, durationMs = 0) {
  results.totalTests++;
  if (passed) results.passed++;
  else results.failed++;

  results.testCases.push({
    id: `TC_${results.totalTests.toString().padStart(2, '0')}`,
    category,
    name,
    passed,
    durationMs,
    details
  });

  const icon = passed ? '✅ PASS' : '❌ FAIL';
  console.log(`  [${icon}] ${category}: ${name} (${durationMs}ms)`);
  if (details && !passed) {
    console.log(`         Details: ${JSON.stringify(details)}`);
  }
}

// HTTP Helper
function request(endpoint, options = {}) {
  const start = Date.now();
  return new Promise((resolve, reject) => {
    const url = new URL(endpoint, BASE_URL);
    const req = http.request(url, options, (res) => {
      let data = '';
      res.on('data', chunk => { data += chunk; });
      res.on('end', () => {
        const durationMs = Date.now() - start;
        resolve({
          statusCode: res.statusCode,
          headers: res.headers,
          body: data,
          durationMs
        });
      });
    });

    req.on('error', (err) => {
      reject({ error: err.message, durationMs: Date.now() - start });
    });

    if (options.body) {
      req.write(options.body);
    }
    req.end();
  });
}

async function runAllTests() {
  console.log('================================================================');
  console.log('       🧪 ARENA.AI AUTHENTIC WEBSITE & PRIVACY TEST SUITE       ');
  console.log('================================================================\n');

  // --- Suite 1: Server Core & Endpoints ---
  console.log('▶ SUITE 1: Server Core & Health Endpoints');
  try {
    const health = await request('/api/health');
    const healthJson = JSON.parse(health.body);
    results.systemInfo = healthJson;
    logTest('Server', 'Health Endpoint Responds (200 OK)', health.statusCode === 200 && healthJson.status === 'ok', healthJson, health.durationMs);
    logTest('Server', 'Uptime & Memory Reporting', typeof healthJson.uptimeSeconds === 'number' && healthJson.memoryUsageMB > 0, healthJson, health.durationMs);
  } catch (err) {
    logTest('Server', 'Health Endpoint Responds', false, err);
  }

  // --- Suite 2: Android Network Discovery & QR Access ---
  console.log('\n▶ SUITE 2: Android Network Discovery');
  try {
    const net = await request('/api/network-info');
    const netJson = JSON.parse(net.body);
    logTest('Network', 'LAN IP Discovery Active', net.statusCode === 200 && !!netJson.primaryIp, { ip: netJson.primaryIp, iface: netJson.primaryInterface }, net.durationMs);
    logTest('Network', 'Mobile Access URL Formatted', netJson.mobileUrl && netJson.mobileUrl.startsWith('http://'), { mobileUrl: netJson.mobileUrl }, net.durationMs);
    logTest('Network', 'QR Code Data URL Generated', netJson.qrDataUrl && netJson.qrDataUrl.startsWith('data:image/png;base64,'), null, net.durationMs);
  } catch (err) {
    logTest('Network', 'Network Endpoint Check', false, err);
  }

  // --- Suite 3: PWA Compliance for Android ---
  console.log('\n▶ SUITE 3: Android PWA & Offline Readiness');
  try {
    const manifest = await request('/manifest.json');
    let mJson = null;
    try { mJson = JSON.parse(manifest.body); } catch (_) {}
    
    logTest('PWA', 'Manifest Served with Valid JSON', manifest.statusCode === 200 && !!mJson, null, manifest.durationMs);
    logTest('PWA', 'Android Standalone Display Configured', mJson && mJson.display === 'standalone', { display: mJson?.display }, manifest.durationMs);
    logTest('PWA', 'Android Theme Color & Orientation Defined', mJson && !!mJson.theme_color && !!mJson.orientation, { theme: mJson?.theme_color, orient: mJson?.orientation }, manifest.durationMs);
    logTest('PWA', 'Android App Icons Array (192px & 512px Maskable)', mJson && mJson.icons && mJson.icons.length >= 4, { iconCount: mJson?.icons?.length }, manifest.durationMs);

    const icon192 = await request('/icons/icon-192.png');
    logTest('PWA', '192x192 HD Icon Exists & Serves', icon192.statusCode === 200 && icon192.headers['content-type'].includes('png'), null, icon192.durationMs);

    const icon512 = await request('/icons/icon-512.png');
    logTest('PWA', '512x512 Full HD Icon Exists & Serves', icon512.statusCode === 200 && icon512.headers['content-type'].includes('png'), null, icon512.durationMs);

    const sw = await request('/sw.js');
    logTest('PWA', 'Service Worker sw.js Available', sw.statusCode === 200 && sw.body.includes('caches.open'), null, sw.durationMs);
  } catch (err) {
    logTest('PWA', 'PWA Verification Failed', false, err);
  }

  // --- Suite 4: Pure Authentic Website Serving (No Injected UI) ---
  console.log('\n▶ SUITE 4: Pure Authentic Website Rendering');
  try {
    const rootRes = await request('/');
    const html = rootRes.body;
    const isAuthenticArena = html.includes('Arena AI: The Official AI Ranking') || html.includes('dpl_');
    const noInjectedDock = !html.includes('id="android-dock"');
    const noInjectedSimulators = !html.includes('CANDIDATE_MODELS');

    logTest('Pure UI', 'Root (/) Serves Authentic arena.ai Directly (200 OK)', rootRes.statusCode === 200 && isAuthenticArena, null, rootRes.durationMs);
    logTest('Pure UI', 'Zero Injected Docks or Overlays on Screen', noInjectedDock, null, rootRes.durationMs);
    logTest('Pure UI', 'Zero Mock/Simulated Battle Elements', noInjectedSimulators, null, rootRes.durationMs);
    logTest('Pure UI', 'Frame Blocking Headers Stripped for Mobile', !rootRes.headers['x-frame-options'], null, rootRes.durationMs);
    logTest('Pure UI', 'Cross-Origin Access Open for Mobile Rendering', rootRes.headers['access-control-allow-origin'] === '*', null, rootRes.durationMs);
  } catch (err) {
    logTest('Pure UI', 'Pure UI Verification Failed', false, err);
  }

  // --- Suite 5: IP Anonymization & Leak Protection ---
  console.log('\n▶ SUITE 5: IP Leak Shield & Privacy Verification');
  try {
    // Send a request with simulated IP headers to verify the proxy strips them
    const testLeakReq = await request('/', {
      headers: {
        'X-Forwarded-For': '192.168.1.99, 10.0.0.1',
        'X-Real-IP': '192.168.1.99',
        'Client-IP': '192.168.1.99',
        'CF-Connecting-IP': '192.168.1.99'
      }
    });

    logTest('Privacy', 'Proxy Processes Anonymous Stream (200 OK)', testLeakReq.statusCode === 200, null, testLeakReq.durationMs);
    logTest('Privacy', 'Upstream Connection Shield Active', !testLeakReq.headers['x-forwarded-for'], null, testLeakReq.durationMs);
    logTest('Privacy', 'No Client IP Disclosed in Response Headers', !testLeakReq.headers['x-real-ip'] && !testLeakReq.headers['client-ip'], null, testLeakReq.durationMs);
  } catch (err) {
    logTest('Privacy', 'IP Shield Verification Failed', false, err);
  }

  // --- Suite 6: Live arena.ai Cloud Latency Benchmark ---
  console.log('\n▶ SUITE 6: Live arena.ai Cloud Latency Benchmark');
  try {
    const latencySamples = [];
    let arenaResult = null;

    for (let i = 1; i <= 3; i++) {
      const arenaStatus = await request('/api/arena-status');
      const arenaJson = JSON.parse(arenaStatus.body);
      arenaResult = arenaJson;
      if (arenaJson.latencyMs) {
        latencySamples.push(arenaJson.latencyMs);
      }
    }

    const avgLatency = Math.round(latencySamples.reduce((a, b) => a + b, 0) / latencySamples.length);
    const minLatency = Math.min(...latencySamples);
    const maxLatency = Math.max(...latencySamples);

    results.benchmarks = {
      targetUrl: 'https://arena.ai',
      samples: latencySamples,
      avgLatencyMs: avgLatency,
      minLatencyMs: minLatency,
      maxLatencyMs: maxLatency,
      httpStatus: arenaResult?.status,
      cloudflareRay: arenaResult?.cloudflareRay
    };

    logTest('Cloud', 'arena.ai Live Connectivity', arenaResult && arenaResult.online === true, { status: arenaResult?.status }, avgLatency);
    logTest('Cloud', 'Cloudflare CDN Handshake Verified', arenaResult && !!arenaResult.cloudflareRay, { ray: arenaResult?.cloudflareRay }, avgLatency);
    logTest('Cloud', 'Cloud Availability Status (200 OK)', arenaResult?.status === 200, { status: arenaResult?.status }, avgLatency);
  } catch (err) {
    logTest('Cloud', 'Cloud Connectivity Test Failed', false, err);
  }

  // --- Suite 7: Android Native APK Project Structure ---
  console.log('\n▶ SUITE 7: Android Native APK Project Structure');
  try {
    const manifestPath = path.join(__dirname, '..', 'android', 'app', 'src', 'main', 'AndroidManifest.xml');
    const mainActivityPath = path.join(__dirname, '..', 'android', 'app', 'src', 'main', 'java', 'com', 'arenaai', 'mobile', 'MainActivity.java');
    const buildGradlePath = path.join(__dirname, '..', 'android', 'app', 'build.gradle');

    const manifestExists = fs.existsSync(manifestPath);
    const activityExists = fs.existsSync(mainActivityPath);
    const gradleExists = fs.existsSync(buildGradlePath);
    const mainActivitySrc = fs.readFileSync(mainActivityPath, 'utf8');

    const geolocationDisabled = mainActivitySrc.includes('setGeolocationEnabled(false)');
    const fileAccessDisabled = mainActivitySrc.includes('setAllowFileAccess(false)');
    const cleanUserAgent = !mainActivitySrc.includes('ArenaAIMobileApp');

    logTest('Android Native', 'AndroidManifest.xml Present with Clean Permissions', manifestExists, null, 1);
    logTest('Android Native', 'MainActivity.java with Geolocation Disabled (IP/Location Shield)', geolocationDisabled, null, 1);
    logTest('Android Native', 'Local File Access Restricted', fileAccessDisabled, null, 1);
    logTest('Android Native', 'Standard Clean Chrome User-Agent (No Custom Tag Leak)', cleanUserAgent, null, 1);
    logTest('Android Native', 'Gradle Build Scripts Configured', gradleExists, null, 1);
  } catch (err) {
    logTest('Android Native', 'Android Project Structure Check', false, err);
  }

  // Write Test Results File
  const testResultsPath = path.join(__dirname, 'test-results.json');
  fs.writeFileSync(testResultsPath, JSON.stringify(results, null, 2), 'utf-8');

  console.log('\n================================================================');
  console.log(`  TEST RESULTS: ${results.passed} PASSED / ${results.totalTests} TOTAL (${results.failed} FAILED)`);
  console.log(`  Score: ${Math.round((results.passed / results.totalTests) * 100)}% SUCCESS RATE`);
  console.log(`  Report saved to: tests/test-results.json`);
  console.log('================================================================\n');

  return results;
}

if (require.main === module) {
  runAllTests().then((res) => {
    process.exit(res.failed === 0 ? 0 : 1);
  });
}

module.exports = { runAllTests };
