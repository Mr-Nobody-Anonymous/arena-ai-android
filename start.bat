@echo off
title Arena.ai Local Dev Proxy
cd /d "%~dp0"
echo ===================================================
echo   Launching Arena.ai Local Development Proxy...
echo   (Optional development inspection utility)
echo ===================================================
node server.js
pause
