@echo off
setlocal

:: 視窗大小設定
mode con: cols=45 lines=18

:: 提示用戶輸入工號
echo ^>^>^> 當前使用者: %USERNAME% ^<^<^<
echo.


:input_username
:: 提示用戶輸入工號
set /p Num=^>^> 請輸入您的工號: 

:: 如果工號未輸入，使用預設值 %USERNAME%
if "%Num%"=="" (
    set "Num=%USERNAME%"
    echo.
    echo ^>^>由於未輸入，預設使用 %USERNAME%
)
echo ------------------------------

:: 設定 NumFolder
set "NumFolder=N:\U\%Num%"

:: 檢查使用者目錄是否存在
dir "C:\Users\%Num%" >nul 2>&1
if errorlevel 1 (
    echo ▲ 找不到使用者 "%Num%"，請重新確認.
    echo ------------------------------
    goto input_username
)


echo.

:: 檢查主要資料夾是否存在
if not exist "%NumFolder%" (
    echo ▲ "%NumFolder%" 資料夾不存在，腳本結束執行。
    pause
    goto :eof
)

:: 檢查權限
:: 嘗試寫入測試檔案以檢查寫入權限
echo 訪問權限檢查 > "%NumFolder%\access_test.txt" 2>nul
if exist "%NumFolder%\access_test.txt" (
    echo --1. 擁有 "%Num%" 資料夾寫入權限。
    echo.
    del "%NumFolder%\access_test.txt" >nul 2>&1
) else (
    echo ▲ 無法寫入，請檢查權限。腳本結束執行。
    pause
    goto :eof
)

:: 建立子資料夾
if not exist "%NumFolder%\Mail" mkdir "%NumFolder%\Mail"
if not exist "%NumFolder%\捷徑" mkdir "%NumFolder%\捷徑"

if not exist "%NumFolder%\Citrix Profile" mkdir "%NumFolder%\Citrix Profile"
if not exist "%NumFolder%\Citrix Profile\Downloads" mkdir "%NumFolder%\Citrix Profile\Downloads"
if not exist "%NumFolder%\Citrix Profile\Music" mkdir "%NumFolder%\Citrix Profile\Music"
if not exist "%NumFolder%\Citrix Profile\Pictures" mkdir "%NumFolder%\Citrix Profile\Pictures"
if not exist "%NumFolder%\Citrix Profile\Videos" mkdir "%NumFolder%\Citrix Profile\Videos"
if not exist "%NumFolder%\Citrix Profile\Documents" mkdir "%NumFolder%\Citrix Profile\Documents"
if not exist "%NumFolder%\Citrix Profile\Desktop" mkdir "%NumFolder%\Citrix Profile\Desktop"
if not exist "%NumFolder%\Citrix Profile\3D Objects" mkdir "%NumFolder%\Citrix Profile\3D Objects"

echo --2. Citrix Profile 資料夾已建立。
echo.

:: 複製檔案
set "source_file=N:\A1B\A1B8\A1B8Z\資訊\電腦登出\電腦登出.lnk"
set "destination_file=%NumFolder%\電腦登出.lnk"

if exist "%source_file%" (
    copy "%source_file%" "%destination_file%" >nul 2>&1
    echo --3. 複製電腦登出 已完成
    echo.
) else (
    echo ▲ 錯誤: 電腦登出不存在。
    pause
)


:: 修改註冊檔
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Downloads" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "My Music" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Music" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "My Pictures" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Pictures" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "My Video" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Videos" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Documents" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Desktop" /f >nul 2>&1

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{0DDD015D-B06C-45D5-8C4C-F59713854639}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Pictures" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{35286A68-3C57-41A1-BBB1-0EAE73D76C95}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Videos" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Downloads" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{7D83EE9B-2244-4E70-B1F5-5393042AF1E4}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Downloads" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{A0C69A99-21C8-4671-8703-7934162FCF1D}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Music" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{F42EE2D3-909F-4907-8871-4C22FC0BF756}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Documents" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{754AC886-DF64-4CBA-86B5-F7FBF4FBCEF5}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Desktop" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{31C0DD25-9439-4F12-BF41-7FF4EDA38722}" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\3D Objects" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "My Music" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Music" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "My Pictures" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Pictures" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "My Video" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Videos" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Personal" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Documents" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Desktop" /t REG_SZ /d "N:\U\%Num%\Citrix Profile\Desktop" /f >nul 2>&1
echo --4. Citrix Profile 設定更改完成。
echo.

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d 1 /f >nul 2>&1
echo --5. 視窗框線更改完成。
echo ------------------------------
echo.


pause
goto :eof

endlocal
