#!/bin/bash -ilex
#获取Git SHA1
GIT_SHA1=`(git show-ref --head --hash=8 2> /dev/null || echo 00000000) | head -n1`
#默认打包类型
DEFAULT_BUILD_TYPE=release
#打包类型
if [ ! $buildType ]; then
type=$DEFAULT_BUILD_TYPE
  else
type=$buildType
fi
#获取版本号
versionCode=""
version=""
versionCodeSpe=""
pubspecFile="pubspec.yaml"
if [ -e $pubspecFile ]
  then
      if [ -r $pubspecFile ]
        then
          if [ -w $pubspecFile ]
            then
              #修改文件
              #webview
              version=`sed -n '18p'  $pubspecFile`
          else
            echo "文件不可写"
          fi
      else
         echo "文件不可读"
      fi
else
   echo "文件不存在"
fi
#对IFS变量 进行替换处理 拆分分号
OLD_IFS="$IFS"
IFS=": "
array=($version)
IFS="$OLD_IFS"
#拆分加号
OLD_IFS="$IFS"
IFS="+"
array=(${array[1]})
IFS="$OLD_IFS"
versionName=${array[0]}
#versionCode=`expr "${versionName}"|sed "s/\.*//g"`
versionCode=${array[1]}
#指定版本号
if [ ! $buildVersionName ]; then
  echo "没有指定版本，默认使用配置文件的版本"
else
  versionName=$buildVersionName
fi
time=$(date "+%m%d")
test=Test
#Android 打包
flutter build apk --$type --obfuscate --split-debug-info=xx --build-name=$versionName --build-number=$versionCode
#执行 iOS 打包
#flutter build ipa --export-options-plist=./debug_export_options/ExportOptions.plist
#修改包名称
#mv "build/app/outputs/flutter-apk/app-${type}.apk" "build/app/outputs/flutter-apk/hn_lottery_${versionName}+${versionCode}_${GIT_SHA1}_${type}.apk"