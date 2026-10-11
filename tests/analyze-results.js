const fs = require('fs');
const path = require('path');

function analyzeResults() {
  const resultsFile = path.join(__dirname, 'test-results.json');
  if (!fs.existsSync(resultsFile)) {
    console.error('No test-results.json found. Run tests first!');
    return;
  }

  const data = JSON.parse(fs.readFileSync(resultsFile, 'utf-8'));
  const overallSuccessRate = Math.round((data.passed / data.totalTests) * 100);

  console.log('================================================================');
  console.log('      📊 ARENA.AI AUDIT VERIFICATION SUMMARY                    ');
  console.log('================================================================');
  console.log(`  Tests Executed:       ${data.totalTests}`);
  console.log(`  Tests Passed:         ${data.passed}`);
  console.log(`  Tests Failed:         ${data.failed}`);
  console.log(`  Success Rate:         ${overallSuccessRate}%`);
  console.log('================================================================\n');
}

if (require.main === module) {
  analyzeResults();
}

module.exports = { analyzeResults };
