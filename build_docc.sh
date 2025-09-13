#!/bin/sh

xcrun xcodebuild docbuild \
    -scheme 'MMExpressionSolver' \
    -destination 'generic/platform=iOS Simulator' \
    -derivedDataPath "$PWD/.derivedData"

xcrun docc process-archive transform-for-static-hosting \
    "$PWD/.derivedData/Build/Products/Debug-iphonesimulator/MMExpressionSolver.doccarchive" \
    --output-path "docc" \
    --hosting-base-path "MMExpressionSolver"

echo '<!DOCTYPE html><html><head><meta http-equiv = "refresh" content = "0; url = https://marcusmiss.github.io/MMExpressionSolver/documentation/mmexpressionsolver" /><link rel="canonical" href="https://marcusmiss.github.io/MMExpressionSolver/documentation/mmexpressionsolver"></head><body></body></html>' > docc/index.html
