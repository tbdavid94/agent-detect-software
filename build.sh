#!/bin/bash

APP_NAME="agent"
VERSION="1.0.0"
BUILDDIR="bin/$VERSION"

# Create the build directory if it doesn't exist
mkdir -p "$BUILDDIR"

echo "Building for Windows amd64..."
GOOS=windows GOARCH=amd64 go build -ldflags "-X main.version=$VERSION" -o "$BUILDDIR/${APP_NAME}-windows-amd64-$VERSION.exe"
echo "Built $BUILDDIR/${APP_NAME}-windows-amd64-$VERSION.exe"

echo "Building for Linux amd64..."
GOOS=linux GOARCH=amd64 go build -ldflags "-X main.version=$VERSION" -o "$BUILDDIR/${APP_NAME}-linux-amd64-$VERSION"
echo "Built $BUILDDIR/${APP_NAME}-linux-amd64-$VERSION"

echo "Building for Linux ARM64..."
GOOS=linux GOARCH=arm64 go build -ldflags "-X main.version=$VERSION" -o "$BUILDDIR/${APP_NAME}-linux-arm64-$VERSION"
echo "Built $BUILDDIR/${APP_NAME}-linux-arm64-$VERSION"

echo "Build completed."
