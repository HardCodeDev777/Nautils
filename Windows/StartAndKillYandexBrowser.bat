@echo off

echo Starting Yandex Browser...
start "" /wait "C:\Program Files\Yandex\YandexBrowser\Application\browser.exe"

fsutil dirty query %systemdrive% >nul
if %errorlevel% neq 0 (
    goto :request_admin
) else (
    goto :kill
)

:request_admin
echo Requesting admin rights...
powershell -Command "Start-Process '%~f0' -Verb RunAs"
exit /b

:kill
echo Killing browser...
taskkill /F /IM browser.exe /T >nul 2>&1
taskkill /F /IM yupdate.exe /T >nul 2>&1
taskkill /F /IM YandexBrowserUpdate.exe /T >nul 2>&1
taskkill /F /IM alice.exe /T >nul 2>&1
taskkill /F /IM browser.exe /T >nul 2>&1
taskkill /F /IM service_update.exe /T >nul 2>&1
taskkill /F /IM yandex.exe /T >nul 2>&1
taskkill /F /IM Yandex /T >nul 2>&1

echo Done.
pause