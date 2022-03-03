#!/bin/bash -ilex


#Android 打包
flutter build apk
#执行 iOS 打包
#flutter build ipa --export-options-plist=./debug_export_options/ExportOptions.plist
#修改包名称
#mv "build/app/outputs/flutter-apk/app-${type}.apk" "build/app/outputs/flutter-apk/hn_lottery_${versionName}+${versionCode}_${GIT_SHA1}_${type}.apk"
