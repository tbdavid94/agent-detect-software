@echo off
SET APP_NAME=agent
SET VERSION=1.0.0
SET BUILDDIR=bin\%VERSION%

echo Creating directory %BUILDDIR%
if not exist "%BUILDDIR%" mkdir "%BUILDDIR%"

echo Building for Windows amd64...
SET GOOS=windows
SET GOARCH=amd64
go build -ldflags "-X main.version=%VERSION%" -o %BUILDDIR%\%APP_NAME%-windows-amd64-%VERSION%.exe
echo Built %BUILDDIR%\%APP_NAME%-windows-amd64-%VERSION%.exe

echo Building for Linux amd64...
SET GOOS=linux
SET GOARCH=amd64
go build -ldflags "-X main.version=%VERSION%" -o %BUILDDIR%\%APP_NAME%-linux-amd64-%VERSION%
echo Built %BUILDDIR%\%APP_NAME%-linux-amd64-%VERSION%

echo Building for Linux ARM64...
SET GOOS=linux
SET GOARCH=arm64
go build -ldflags "-X main.version=%VERSION%" -o %BUILDDIR%\%APP_NAME%-linux-arm64-%VERSION%
echo Built %BUILDDIR%\%APP_NAME%-linux-arm64-%VERSION%

echo Build completed.