@echo off
chcp 65001 & REM Türkçe karakterlerin düzgün çalışması için. / Unicode support.
color b & REM Renklendirme / Coloring
cls & REM Ekranı temizler. / Clears the screen.
net session > nul 2>&1 & REM Yönetici olarak çalıştırma kontrolü. / Administrator privileges control
if %errorlevel% == 2 goto :EXIT else goto START:
:START
sc config "WSearch" start= disabled & REM Windows Search hizmetini devre dışı bırakır. / Disables the Windows Search service.
sc config "wuauserv" start= disabled & REM Windows Update hizmetini devre dışı bırakır. / Disables the Windows Update service. 
sc config "SysMain" start= disabled & REM SysMain hizmetini devre dışı bırakır. / Disables the SysMain service.
sc config "WerSvc" start= disabled & REM Windows Hata Raporlama hizmetini devre dışı bırakır. / Disables the Windows Error Reporting service
echo Hizmetler devre dışı bırakıldı.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f & REM Arka plan uygulamalarını kapatır. / Disables the background apps.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "Allow Telemetry" /d 0 /f & REM Telemetry kapatır. / Disables the Windows Telemetry.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f & REM Startup zamanını hızlandırır. / Speed up startup.
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f & REM Numlock varsayılan olarak açık kalır. / Numlock on by default.
fsutil behavior set encryptpagingfile 0 & REM Sanal RAM özelliğini kapatır. / Disables the virtual RAM.
set folder="%temp%" 
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s /q || del "%%i" /s /q) & REM Geçici dosyaları temizler. / Deleting temp files and folders.
powershell -ExecutionPolicy ByPass -Command "$ScriptFromGitHub=Invoke-WebRequest "https://raw.githubusercontent.com/GokhanTurk/SlowHDDFixWin10/main/DisableChromeReport.ps1" -UseBasicParsing;Invoke-Expression $($ScriptFromGitHub.Content)"
REM powershell scripti chrome report toolunu bloklamak içindir. / Disables the Chrome's reportin feature.
powershell -ExecutionPolicy ByPass -Command Write-Host -fore Green DEĞİŞİKLİKLERİN ETKİLİ OLMASI İÇİN BİLGİSAYARI YENİDEN BAŞLATMANIZ GEREKİYOR!
powershell -ExecutionPolicy ByPass -Command Write-Host -fore Green Changes to this settings require a reboot to take effect.
pause
exit
:EXIT
echo -                                -
echo Yönetici olarak çalıştırmalısınız!
echo -                                -
ping 127.0.0.1 > nul
exit
