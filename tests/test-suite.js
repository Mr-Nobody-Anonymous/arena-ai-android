const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 3000;
const BASE_URL = `http://127.0.0.1:${PORT}`;

// Test Collector
const results = {
  timestamp: new Date().toISOString(),
  totalTests: 0,
  passed: 0,
  failed: 0,
  testCases: []
};

function logTest(category, name, passed, details = null) {
  results.totalTests++;
  if (passed) results.passed++;
  else results.failed++;

  results.testCases.push({
    id: `TC_${results.totalTests.toString().padStart(2, '0')}`,
    category,
    name,
    passed,
    details
  });

  const icon = passed ? '✅ PASS' : '❌ FAIL';
  console.log(`  [${icon}] ${category}: ${name}`);
  if (details && !passed) {
    console.log(`         Details: ${JSON.stringify(details)}`);
  }
}

function request(endpoint, options = {}) {
  return new Promise((resolve, reject) => {
    const url = new URL(endpoint, BASE_URL);
    const req = http.request(url, options, (res) => {
      let data = '';
      res.on('data', chunk => { data += chunk; });
      res.on('end', () => {
        resolve({
          statusCode: res.statusCode,
          headers: res.headers,
          body: data
        });
      });
    });
    req.on('error', err => reject(err));
    if (options.body) req.write(options.body);
    req.end();
  });
}

async function runAllTests() {
  console.log('================================================================');
  console.log('       🧪 ARENA.AI AUDIT COMPLIANCE & INTEGRITY TEST SUITE      ');
  console.log('================================================================\n');

  // --- Suite 1: Local Development Server ---
  console.log('▶ SUITE 1: Local Development Server & Diagnostics');
  try {
    const health = await request('/api/health');
    const healthJson = JSON.parse(health.body);
    logTest('Dev Server', 'Health Endpoint Responds (200 OK)', health.statusCode === 200 && healthJson.status === 'ok');
    logTest('Dev Server', 'Node & Memory Reporting Valid', typeof healthJson.uptimeSeconds === 'number' && healthJson.memoryUsageMB > 0);
  } catch (err) {
    logTest('Dev Server', 'Health Endpoint Responds', false, err.message);
  }

  // --- Suite 2: Android Native APK Project Structure ---
  console.log('\n▶ SUITE 2: Android Architecture & Security Hardening');
  const projectRoot = path.join(__dirname, '..');
  const androidDir = path.join(projectRoot, 'android');
  const appDir = path.join(androidDir, 'app');
  const srcDir = path.join(appDir, 'src', 'main');
  const resDir = path.join(srcDir, 'res');

  const manifestPath = path.join(srcDir, 'AndroidManifest.xml');
  const mainActivityPath = path.join(srcDir, 'java', 'ai', 'arena', 'mobile', 'MainActivity.java');
  const buildGradlePath = path.join(appDir, 'build.gradle');
  const gradlePropertiesPath = path.join(androidDir, 'gradle.properties');
  const proguardPath = path.join(appDir, 'proguard-rules.pro');

  const manifestSrc = fs.existsSync(manifestPath) ? fs.readFileSync(manifestPath, 'utf8') : '';
  const mainActivitySrc = fs.existsSync(mainActivityPath) ? fs.readFileSync(mainActivityPath, 'utf8') : '';
  const buildGradleSrc = fs.existsSync(buildGradlePath) ? fs.readFileSync(buildGradlePath, 'utf8') : '';
  const gradlePropertiesSrc = fs.existsSync(gradlePropertiesPath) ? fs.readFileSync(gradlePropertiesPath, 'utf8') : '';

  logTest('Android Core', 'Package Unified to ai.arena.mobile',
    buildGradleSrc.includes("applicationId \"ai.arena.mobile\"") && mainActivitySrc.includes("package ai.arena.mobile;"));

  logTest('Android Core', 'Target SDK 34+ and Modern Min SDK 26 configured',
    buildGradleSrc.includes("minSdk 26") && buildGradleSrc.includes("targetSdk 34"));

  logTest('Android Security', 'Cleartext Traffic Disabled (HTTPS only)',
    manifestSrc.includes('android:usesCleartextTraffic="false"'));

  logTest('Android Security', 'Application Backup Disabled (Token protection)',
    manifestSrc.includes('android:allowBackup="false"'));

  logTest('Android Security', 'Minimal Permissions (INTERNET only, ACCESS_NETWORK_STATE removed)',
    manifestSrc.includes('android.permission.INTERNET') && !manifestSrc.includes('ACCESS_NETWORK_STATE'));

  logTest('Android Security', 'Client Geolocation Disabled (Prevents physical location leaks)',
    mainActivitySrc.includes('setGeolocationEnabled(false)'));

  logTest('Android Security', 'Local File Access Restricted (Blocks file:// scheme)',
    mainActivitySrc.includes('setAllowFileAccess(false)') && mainActivitySrc.includes('setAllowContentAccess(false)'));

  logTest('Android Security', 'Navigation Allow-List Configured (External links open in system browser)',
    mainActivitySrc.includes('ALLOWED_HOST_SUFFIXES') && mainActivitySrc.includes('Intent.ACTION_VIEW'));

  logTest('Android Navigation', 'Modern OnBackPressedDispatcher used (API 34/35/36 compliant)',
    mainActivitySrc.includes('OnBackPressedCallback') && !mainActivitySrc.includes('onKeyDown('));

  logTest('Android UX', 'Full File Chooser with Multi-select ClipData Support',
    mainActivitySrc.includes('onShowFileChooser') && mainActivitySrc.includes('getClipData()'));

  logTest('Android UX', 'Session & Cookie Persistence Configured',
    mainActivitySrc.includes('CookieManager.getInstance().flush()'));

  logTest('Android UX', 'Pull-to-Refresh with SwipeRefreshLayout Integrated',
    mainActivitySrc.includes('SwipeRefreshLayout'));

  logTest('Android Build', 'AndroidX Enabled in gradle.properties',
    gradlePropertiesSrc.includes('android.useAndroidX=true'));

  logTest('Android Build', 'ProGuard / R8 Rules Present',
    fs.existsSync(proguardPath) && fs.readFileSync(proguardPath, 'utf8').includes('ai.arena.mobile'));

  // --- Suite 3: Adaptive Icons & Branding ---
  console.log('\n▶ SUITE 3: Official Brand Icons & Adaptive Drawables');
  const bgVector = path.join(resDir, 'drawable', 'ic_launcher_background.xml');
  const fgVector = path.join(resDir, 'drawable', 'ic_launcher_foreground.xml');
  const monoVector = path.join(resDir, 'drawable', 'ic_launcher_monochrome.xml');
  const anydpiLauncher = path.join(resDir, 'mipmap-anydpi-v26', 'ic_launcher.xml');
  const anydpiRound = path.join(resDir, 'mipmap-anydpi-v26', 'ic_launcher_round.xml');

  const bgSrc = fs.existsSync(bgVector) ? fs.readFileSync(bgVector, 'utf8') : '';
  const fgSrc = fs.existsSync(fgVector) ? fs.readFileSync(fgVector, 'utf8') : '';

  logTest('Branding', 'Adaptive Background Vector is Pure Black (#000000)',
    bgSrc.includes('#000000') && !bgSrc.includes('#26a69a'));

  logTest('Branding', 'Adaptive Foreground Vector contains Official Classical Pillar Mark',
    fgSrc.includes('pathData="M57.5364') && fgSrc.includes('#FFFFFF') && !fgSrc.includes('robot'));

  logTest('Branding', 'Android 13+ Themed Monochrome Vector Present',
    fs.existsSync(monoVector));

  logTest('Branding', 'Adaptive Launcher XML files configured in mipmap-anydpi-v26',
    fs.existsSync(anydpiLauncher) && fs.existsSync(anydpiRound));

  const densityPngsPresent = ['mipmap-mdpi', 'mipmap-hdpi', 'mipmap-xhdpi', 'mipmap-xxhdpi', 'mipmap-xxxhdpi'].every(d =>
    fs.existsSync(path.join(resDir, d, 'ic_launcher.png')) && fs.existsSync(path.join(resDir, d, 'ic_launcher_round.png'))
  );
  logTest('Branding', 'Density PNG Icons Present across all densities (mdpi to xxxhdpi)', densityPngsPresent);

  // --- Suite 4: Gradle Wrapper & Build System ---
  console.log('\n▶ SUITE 4: Gradle Wrapper & CI Configuration');
  const gradlewExists = fs.existsSync(path.join(androidDir, 'gradlew'));
  const gradlewBatExists = fs.existsSync(path.join(androidDir, 'gradlew.bat'));
  const wrapperJarExists = fs.existsSync(path.join(androidDir, 'gradle', 'wrapper', 'gradle-wrapper.jar'));
  const wrapperProps = path.join(androidDir, 'gradle', 'wrapper', 'gradle-wrapper.properties');
  const wrapperPropsSrc = fs.existsSync(wrapperProps) ? fs.readFileSync(wrapperProps, 'utf8') : '';

  logTest('Build System', 'Gradle Wrapper Shell Script (gradlew) Present', gradlewExists);
  logTest('Build System', 'Gradle Wrapper Windows Batch (gradlew.bat) Present', gradlewBatExists);
  logTest('Build System', 'Gradle Wrapper Jar Present', wrapperJarExists);
  logTest('Build System', 'Gradle 8.2 configured in wrapper properties', wrapperPropsSrc.includes('gradle-8.2'));

  const ciWorkflowPath = path.join(projectRoot, '.github', 'workflows', 'build.yml');
  const ciSrc = fs.existsSync(ciWorkflowPath) ? fs.readFileSync(ciWorkflowPath, 'utf8') : '';
  logTest('CI / Automation', 'GitHub Actions Build Workflow Present',
    ciSrc.includes('actions/setup-java@v4') && ciSrc.includes('assembleDebug'));

  // --- Suite 5: Legal & Community Governance ---
  console.log('\n▶ SUITE 5: Legal & Community Documentation');
  logTest('Legal', 'Apache-2.0 LICENSE File Present', fs.existsSync(path.join(projectRoot, 'LICENSE')));
  logTest('Legal', 'NOTICE File with Brand & Third-Party Attribution Present', fs.existsSync(path.join(projectRoot, 'NOTICE')));
  logTest('Legal', 'PRIVACY.md Detailing Zero Telemetry & Client Safeguards Present', fs.existsSync(path.join(projectRoot, 'PRIVACY.md')));
  logTest('Security', 'SECURITY.md Responsible Disclosure Policy Present', fs.existsSync(path.join(projectRoot, 'SECURITY.md')));
  logTest('Community', 'CONTRIBUTING.md Guidelines Present', fs.existsSync(path.join(projectRoot, 'CONTRIBUTING.md')));
  logTest('Community', 'CODE_OF_CONDUCT.md Present', fs.existsSync(path.join(projectRoot, 'CODE_OF_CONDUCT.md')));
  logTest('Community', 'CHANGELOG.md Present with Audit Remediation Log', fs.existsSync(path.join(projectRoot, 'CHANGELOG.md')));

  // --- Suite 6: Smali Dump Retirement ---
  console.log('\n▶ SUITE 6: Legacy Codebase Purge');
  const smaliTreeRetired = !fs.existsSync(path.join(projectRoot, 'arena_standalone_apk'));
  const publicStaleRemoved = !fs.existsSync(path.join(projectRoot, 'public'));
  const dataStaleRemoved = !fs.existsSync(path.join(projectRoot, 'data'));

  logTest('Hygiene', 'Decompiled Smali Tree (3,300+ legacy files) Completely Removed', smaliTreeRetired);
  logTest('Hygiene', 'Unused Shell HTML and Stale Data Files Removed', publicStaleRemoved && dataStaleRemoved);

  // Write Test Results File
  const testResultsPath = path.join(__dirname, 'test-results.json');
  fs.writeFileSync(testResultsPath, JSON.stringify(results, null, 2), 'utf-8');

  console.log('\n================================================================');
  console.log(`  TEST RESULTS: ${results.passed} PASSED / ${results.totalTests} TOTAL (${results.failed} FAILED)`);
  console.log(`  Score: ${Math.round((results.passed / results.totalTests) * 100)}% SUCCESS RATE`);
  console.log('================================================================\n');

  return results;
}

if (require.main === module) {
  runAllTests().then((res) => {
    process.exit(res.failed === 0 ? 0 : 1);
  });
}

module.exports = { runAllTests };
