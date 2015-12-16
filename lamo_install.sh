#!/bin/sh

#  lamo_install.sh
#  Lamo
#
#  Created by Ethan Arbuckle on 6/23/15.
#  Copyright © 2015 CortexDevTeam. All rights reserved.

rm -rf Builds/ || true
xctool -sdk iphoneos -project Lamo.xcodeproj/ -scheme Lamo CODE_SIGNING_REQUIRED=NO owner=$1
scp -P 2222 Builds/Lamo.dylib root@localhost:/Library/MobileSubstrate/DynamicLibraries/Lamo.dylib
scp -P 2222 Builds/LamoClient.dylib root@localhost:/Library/MobileSubstrate/DynamicLibraries/LamoClient.dylib
ssh root@localhost -p 2222 "ldid -S /Library/MobileSubstrate/DynamicLibraries/Lamo.dylib && killall SpringBoard"