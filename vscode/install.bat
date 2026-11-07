@REM VSCode keybindings.json をインストールするスクリプト

@echo off
setlocal enabledelayedexpansion

set VSCODE_USER_DIR=%APPDATA%\Code\User
set KEYBINDINGS_PATH=%VSCODE_USER_DIR%\keybindings.json
set BACKUP_PATH=%VSCODE_USER_DIR%\keybindings.json.backup

echo VSCode Emacs-style keybindings をインストール中...
echo.

if not exist "%VSCODE_USER_DIR%" (
    echo ❌ VSCode User ディレクトリが見つかりません: %VSCODE_USER_DIR%
    echo VSCode をインストールして一度起動してください。
    exit /b 1
)

if exist "%KEYBINDINGS_PATH%" (
    echo ⚠️  既存の keybindings.json が見つかりました。
    copy "%KEYBINDINGS_PATH%" "%BACKUP_PATH%"
    echo ✅ バックアップを作成しました: %BACKUP_PATH%
    echo.
)

set SCRIPT_DIR=%~dp0
copy "%SCRIPT_DIR%keybindings.json" "%KEYBINDINGS_PATH%"

if %errorlevel% equ 0 (
    echo ✅ インストール完了！
    echo.
    echo 設定ファイル: %KEYBINDINGS_PATH%
    echo.
    echo テスト方法:
    echo   1. VSCode が起動中の場合は再起動してください
    echo   2. Alt+X を押してコマンドパレットが開くか確認
    echo.
    if exist "%BACKUP_PATH%" (
        echo 元に戻したい場合:
        echo   copy "%BACKUP_PATH%" "%KEYBINDINGS_PATH%"
    )
) else (
    echo ❌ インストール失敗
    exit /b 1
)
