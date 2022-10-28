@echo off
chcp 65001 & REM Türkçe karakterlerin düzgün çalışması için.
color b & REM Renklendirme
cls & REM Ekranı temizler.
net session > nul 2>&1 & REM Yönetici olarak çalıştırma kontrolü. 
if %errorlevel% == 2 goto :EXIT else goto START:
:START
sc config "WSearch" start= disabled & REM Windows Search hizmetini devre dışı bırakır.
sc config "wuauserv" start= disabled & REM Windows Update hizmetini devre dışı bırakır.
sc config "SysMain" start= disabled & REM SysMain hizmetini devre dışı bırakır.
sc config "WerSvc" start= disabled & REM Windows Hata Raporlama hizmetini devre dışı bırakır.
echo Hizmetler devre dışı bırakıldı.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f & REM Arka plan uygulamalarını kapatır.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "Allow Telemetry" /d 0 /f & REM Telemetry kapatır.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f & REM Startup zamanını hızlandırır.
fsutil behavior set encryptpagingfile 0 & REM Sanal RAM özelliğini kapatır. 
set folder="%temp%" 
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s /q || del "%%i" /s /q)
powershell -ExecutionPolicy ByPass -Command "$ScriptFromGitHub=Invoke-WebRequest "https://raw.githubusercontent.com/GokhanTurk/SlowHDDFixWin10/main/DisableChromeReport.ps1" -UseBasicParsing;Invoke-Expression $($ScriptFromGitHub.Content)"
pause
exit
:EXIT
echo -                                -
echo Yönetici olarak çalıştırmalısınız!
echo -                                -
ping 127.0.0.1 > nul
exit