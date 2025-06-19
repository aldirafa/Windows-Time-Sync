:: Script to stop and start windows time service
:: after refreshing service status, resync time

@echo off

:: ————————————————
:: Check for admin privileges
:: ————————————————
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Tidak ada hak admin. Mencoba meminta hak administrator...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
title Windows Time Sync Utility
color 0A

echo.
echo =====================================
echo       🚀 Windows Time Sync 🚀
echo =====================================
echo.

echo [INFO] Stopping service: W32Time...
net stop W32Time >nul 2>&1 && (
    echo [ OK ] W32Time service stopped.
) || (
    echo [FAIL] W32Time service stopping failed.
)

echo.
echo [INFO] Running service: W32Time...
net start W32Time >nul 2>&1 && (
    echo [ OK ] W32Time service running.
) || (
    echo [FAIL] W32Time service starting failed.
)

echo.
echo [INFO] Resyncing time...
W32tm /resync >nul 2>&1 && (
    echo [ OK ] Time resynced.
) || (
    echo [FAIL] Time resynchronisation failure.
)

