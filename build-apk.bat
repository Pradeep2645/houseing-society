@echo off
echo ========================================================
echo   Building Housing Society Management Android APK
echo ========================================================

cd /d "%~dp0frontend"
echo 1. Building Angular production bundle...
call npm run build
if %ERRORLEVEL% neq 0 (
    echo Angular build failed!
    exit /b %ERRORLEVEL%
)

echo 2. Syncing Capacitor Android assets...
call npx cap sync android
if %ERRORLEVEL% neq 0 (
    echo Capacitor sync failed!
    exit /b %ERRORLEVEL%
)

echo 3. Setting JDK 21 (Android Studio JBR)...
set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo 4. Compiling native APK with Gradle...
cd android
call .\gradlew.bat assembleDebug
if %ERRORLEVEL% neq 0 (
    echo Gradle APK build failed!
    exit /b %ERRORLEVEL%
)

echo 5. Copying APK to root directory...
cd /d "%~dp0"
copy /y "frontend\android\app\build\outputs\apk\debug\app-debug.apk" "housing-society.apk"

echo ========================================================
echo   SUCCESS! APK generated: housing-society.apk
echo ========================================================
pause
