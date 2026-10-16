@echo off
chcp 65001 >nul
color 0A
echo ===================================================
echo     Удаление сбойных драйверов Intel Bluetooth
echo ===================================================
echo.

net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Права администратора подтверждены.
) else (
    echo [ОШИБКА] Этот скрипт нужно запустить от имени Администратора!
    echo Нажмите любую клавишу для выхода...
    pause >nul
    exit /b
)

echo.
echo Поиск драйверов (это может занять несколько секунд)...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$drivers = Get-WindowsDriver -Online | Where-Object { $_.ProviderName -match 'Intel' -and $_.ClassName -match 'Bluetooth' }; if ($drivers) { foreach ($drv in $drivers) { Write-Host \"Удаление $($drv.Driver)...\" -ForegroundColor Yellow; pnputil /delete-driver $drv.Driver /uninstall /force } } else { Write-Host 'Драйверы Intel Bluetooth в системе не найдены.' -ForegroundColor Green }"

echo.
echo ===================================================
echo Готово! Теперь откройте Центр обновления Windows
echo и установите свежие драйверы.
echo ===================================================
pause