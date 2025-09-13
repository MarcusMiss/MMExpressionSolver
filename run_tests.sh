#!/bin/bash

SCHEME='MMExpressionSolver'
#DESTINATION='platform=iOS Simulator,OS=18.4,name=iPhone 16'
DESTINATION='platform=macOS'

set -o pipefail && xcodebuild test -scheme $SCHEME -destination "$DESTINATION" -disableAutomaticPackageResolution CODE_SIGNING_ALLOWED='NO'
