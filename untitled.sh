echo 'run1----prelaunch.sh-------'
GIT_SHA1=`(git show-ref --head --hash=8 2> /dev/null || echo 00000000) | head -n1`
DEFAULT_BUILD_TYPE=release
if [ ! $buildType ]; then
type=$DEFAULT_BUILD_TYPE
  else
type=$buildType
fi
echo 'run2----prelaunch.sh-------'
versionCode=""
version=""
versionCodeSpe=""
pubspecFile="pubspec.yaml"
echo 'run2.5----prelaunch.sh-------'
if [ -e $pubspecFile ]
  then
      if [ -r $pubspecFile ]
        then
          if [ -w $pubspecFile ]
            then
              #webview
              version=`sed -n '18p'  $pubspecFile`
          else
            echo "noW"
          fi
      else
         echo "no"
      fi
else
   echo "no"
fi
echo 'run3----prelaunch.sh-------'
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
  echo "noVersion"
else
  versionName=$buildVersionName
fi
time=$(date "+%m%d")
test=Test
echo 'run4----prelaunch.sh-------'
flutter build apk --$type --obfuscate --split-debug-info=xx --build-name=$versionName --build-number=$versionCode
#flutter build ipa --export-options-plist=./debug_export_options/ExportOptions.plist
cp -rf "build/app/outputs/flutter-apk/app-${type}.apk" build/app/
apkNewName=flutter_build_${versionName}+${versionCode}_${GIT_SHA1}_${type}
mv "build/app/app-${type}.apk" "build/app/${apkNewName}.apk"
echo 'end----prelaunch.sh-------'
