#!/bin/sh

#  upload.sh
#  huabanforipad
#
#  Created by Nicholas Tau on 11/11/13.
#  Copyright (c) 2013 huaban. All rights reserved.

#commit=`git rev-parse --short HEAD`
#branch=`git rev-parse --abbrev-ref HEAD`
#version=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${INFOPLIST_FILE}"`

#更新日志，默认为Autoupload
#changelog=`git log -5 --pretty=%B`
changelog="Autoupload"
#目标ipa文件的路径
ipaFilePath="/Users/demon/Desktop/"
#目标ipa文件名
ipaName="xiaonimei.ipa"
#目标dsym文件名(保留参数，未知原因，目前dsym不可用)-F dsym=@$dsymName
dsymName="xiaonimei.app.dSYM.zip"
#本地TOT服务的upload地址
OTAPostPath="localhost:3000/admin/upload"

#进入ipa文件当前位于的目录
cd $ipaFilePath
#curl post ipa
curl -v -F app_version[change_log]="$changelog" -F ipa=@$ipaName $OTAPostPath
