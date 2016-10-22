#  stamp-rev-version.sh
#  Spex
#
#  Created by Spex on 11/13/14.
#  Copyright (c) 2014 FieldTek, Inc. All rights reserved.
#
#  Update build number with number of git commits

sourceDir=$SRCROOT

cd $sourceDir

appVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$sourceDir/Spex/Info.plist"`
buildNumber=$(git rev-list HEAD | wc -l | tr -d ' ')
buildTag=$(echo "$appVersion.$buildNumber")

echo "Build Dir: $buildDir"
echo "App Version: $appVersion"
echo "Build Number: $buildNumber"
echo "Build Tag: $buildTag"

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$sourceDir/Spex/Info.plist"

git tag -a "$buildTag" -m "$buildTag"
git commit -am "$buildTag"
git push --tags
git push

#
