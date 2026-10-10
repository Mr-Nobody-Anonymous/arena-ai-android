@echo off
title Arena.ai Automated Test & Analysis
cd /d "%~dp0"
echo ===================================================
echo   Running Comprehensive Automated Tests...
echo ===================================================
npm test
pause
