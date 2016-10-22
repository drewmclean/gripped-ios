
#  stamp-rev-version.sh
#  Spex
#
#  Created by Spex on 11/13/14.
#  Copyright (c) 2014 FieldTek, Inc. All rights reserved.

#Update build number with number of git commits

srcRoot=$1

cd $srcRoot

echo "Running push-rev-version.sh"

#ls -al
xcodebuild -project Spex.xcodeproj -target Spex -showBuildSettings

version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$srcRoot/Spex/Info.plist"`
buildNumber=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$srcRoot/Spex/Info.plist"`

buildTag=$(echo "$version.$buildNumber")

echo "Source Root: $srcRoot"
echo "Version: $version"
echo "Build Number: $buildNumber"
echo "Build Tag: $buildTag"

git tag -a "$buildTag" -m "$buildTag"
git commit -am "Updating version string to $buildTag"
git push --tags
git push

