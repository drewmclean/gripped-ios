#  stamp-rev-version.sh
#  GrippedAthletics
#
#  Created by GrippedAthletics on 10/21/2016.
#  Copyright (c) 2016 GrippedAthletics All rights reserved.
#
#  Update build number with number of git commits

cd $SOURCE_ROOT

infoPlistPath="$BUILT_PRODUCTS_DIR/$INFOPLIST_PATH"
appVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$infoPlistPath"`
buildNumber=$(git rev-list HEAD | wc -l | tr -d ' ')
buildTag=$(echo "$appVersion.$buildNumber")

echo "Build Dir: $buildDir"
echo "App Version: $appVersion"
echo "Build Number: $buildNumber"
echo "Build Tag: $buildTag"

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" $infoPlistPath

git tag -a "$buildTag" -m "$buildTag"
git push --tags
