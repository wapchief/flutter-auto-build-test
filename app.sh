#!/bin/bash -ilex
#Git SHA1
GIT_SHA1=`(git show-ref --head --hash=8 2> /dev/null || echo 00000000) | head -n1`
DEFAULT_BUILD_TYPE=release
if [ ! $buildType ]; then
type=$DEFAULT_BUILD_TYPE
  else
type=$buildType
fi
versionCode=""
version=""
versionCodeSpe=""
pubspecFile="pubspec.yaml"
echo '-----build-----1-'
if [ -e $pubspecFile ]
  then
      if [ -r $pubspecFile ]
        then
          if [ -w $pubspecFile ]
            then
              #webview
              version=`sed -n '18p'  $pubspecFile`
          else
            echo "no -w"
          fi
      else
         echo "no -r"
      fi
else
   echo "no -e"
fi
echo '-----build-----2-'
OLD_IFS="$IFS"
IFS=": "
array=($version)
IFS="$OLD_IFS"
OLD_IFS="$IFS"
IFS="+"
array=(${array[1]})
IFS="$OLD_IFS"
versionName=${array[0]}
#versionCode=`expr "${versionName}"|sed "s/\.*//g"`
versionCode=`expr "${array[1]}"|sed "s/\r//g"`
if [ ! $buildVersionName ]; then
  echo "no version code"
else
  versionName=$buildVersionName
fi
time=$(date "+%m%d")
test=Test
echo '-----build-----3-'
#Android
flutter build apk --$type --obfuscate --split-debug-info=xx --build-name=$versionName --build-number=$versionCode
#iOS
#flutter build ipa --export-options-plist=./debug_export_options/ExportOptions.plist
cp -rf "build/app/outputs/flutter-apk/app-${type}.apk" build/app/
apkNewName=flutter_build_${versionName}+${versionCode}_${GIT_SHA1}_${type}
mv "build/app/app-${type}.apk" "build/app/${apkNewName}.apk"