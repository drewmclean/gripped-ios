
#  stamp-rev-version-ci.sh
#  Spex
#
#  Created by Andrew Mclean on 11/14/14.
#  Copyright (c) 2014 FieldTek, Inc. All rights reserved.

buildNumber=$(git rev-list HEAD | wc -l | tr -d ' ')
echo "Build Number: $buildNumber"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "Spex/Spex-Info.plist"
cat "Spex/Spex-Info.plist"
git tag -a "$buildNumber" -m "$buildNumber"
git push --tags
