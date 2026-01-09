@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ===== COLOR THEME =====
color 0A
title ProxVN Launcher

:: ===== BANNER =====
cls
echo.
echo    ██████╗ ██████╗  ██████╗ ██╗  ██╗██╗   ██╗███╗   ██╗
echo    ██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝╚██╗ ██╔╝████╗  ██║
echo    ██████╔╝██████╔╝██║   ██║ ╚███╔╝  ╚████╔╝ ██╔██╗ ██║
echo    ██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗   ╚██╔╝  ██║╚██╗██║
echo    ██║     ██║  ██║╚██████╔╝██╔╝ ██╗   ██║   ██║ ╚████║
echo    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝
echo.
echo            ProxVN Tunnel Launcher
echo        --------------------------------
echo.

:: ===== INPUT =====
set /p HOST=➤ Host   [127.0.0.1]: 
if "%HOST%"=="" set HOST=127.0.0.1

set /p PORT=➤ Port   [vd: 3389 / 80]: 
if "%PORT%"=="" (
  echo.
  echo [✗] Port khong duoc de trong
  timeout /t 2 >nul
  exit
)

set /p PROTO=➤ Proto  [tcp / udp]: 
if "%PROTO%"=="" set PROTO=tcp

:: ===== VALIDATE =====
if /I not "%PROTO%"=="tcp" if /I not "%PROTO%"=="udp" (
  echo.
  echo [✗] Proto khong hop le! Chi nhan tcp hoac udp
  timeout /t 2 >nul
  exit
)

:: ===== SUMMARY =====
echo.
echo ========================================
echo   ✓ Cấu hình tunnel
echo ----------------------------------------
echo   Host  : %HOST%
echo   Port  : %PORT%
echo   Proto : %PROTO%
echo ========================================
echo.

echo [→] Dang khoi chay ProxVN...
timeout /t 1 >nul

:: ===== RUN =====
start "ProxVN Tunnel" cmd /k proxvn.exe --host %HOST% --port %PORT% --proto %PROTO%

echo.
echo [✓] Da mo ProxVN o cua so rieng
echo [i] Cua so launcher se tu dong dong
timeout /t 2 >nul
exit
