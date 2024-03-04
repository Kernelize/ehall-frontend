cd ./ehall-networking
make clean
make all
cd ..
cd ./ehall-swift
xcodebuild clean -project Ehall.xcodeproj -scheme Ehall -configuration Release -sdk iphoneos
xcodebuild build -project Ehall.xcodeproj -scheme Ehall -configuration Release -sdk iphoneos
xcodebuild archive -project Ehall.xcodeproj -scheme Ehall -archivePath ../Ehall.xcarchive -sdk iphoneos
