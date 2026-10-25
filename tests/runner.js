const { app, server } = require('../server');
const { runAllTests } = require('./test-suite');
const { analyzeResults } = require('./analyze-results');

async function main() {
  console.log('Starting Arena.ai server for automated test run...');
  
  try {
    const results = await runAllTests();
    console.log('Analyzing test outputs and generating report...');
    analyzeResults();

    const exitCode = results.failed > 0 ? 1 : 0;
    if (results.failed > 0) {
      console.error(`❌ Completed with ${results.failed} failures.`);
    } else {
      console.log('✨ All tests passed flawlessly! System fully verified.');
    }

    process.exitCode = exitCode;
    if (server && server.close) {
      server.close();
    }
  } catch (err) {
    console.error('Fatal test error:', err);
    process.exit(1);
  }
}

main();
