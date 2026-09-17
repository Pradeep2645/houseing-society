Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "   Building Housing Society Management Android APK" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

$rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$rootDir\frontend"

Write-Host "1. Building Angular production bundle..." -ForegroundColor Yellow
npm run build

Write-Host "2. Syncing Capacitor Android assets..." -ForegroundColor Yellow
npx cap sync android

Write-Host "3. Setting JDK 21 (Android Studio JBR)..." -ForegroundColor Yellow
$env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"

Write-Host "4. Compiling native APK with Gradle..." -ForegroundColor Yellow
Set-Location "$rootDir\frontend\android"
.\gradlew.bat assembleDebug

Write-Host "5. Copying APK to root directory..." -ForegroundColor Yellow
Set-Location "$rootDir"
Copy-Item "frontend\android\app\build\outputs\apk\debug\app-debug.apk" "housing-society.apk" -Force

Write-Host "========================================================" -ForegroundColor Green
Write-Host "   SUCCESS! APK generated: housing-society.apk" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
