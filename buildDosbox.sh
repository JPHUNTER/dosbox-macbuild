#!/bin/sh
set -e

if [ "$1" = "32" ]
then
	OPTIONS='--build=i386-apple-darwin CFLAGS="-arch i386 -O2 -pipe" CXXFLAGS="-arch i386 -O2 -pipe" LDFLAGS="-arch i386"'
elif [ "$1" = "64" ]
then
	OPTIONS=""
else
	echo "Please specify the target architecture as either 32 or 64"
	echo "Usage: buildDosbox.sh <architecture>"
	exit
fi

BUILD_DIR=`pwd`/`mktemp -d dosbox-build.XXX`
COPYRIGHT_TEXT="Copyright 2002-`date +'%Y'` The DOSBox Team, compiled by $USER"

# Dosbox
#backup location
#svn checkout https://github.com/JPHUNTER/dosboxrm dosbox-src
#live dev location
svn checkout https://github.com/jrdennisoss/dosboxrm dosbox-src
brew install autoconf automake libtool sdl12-compat
cd dosbox-src
cd trunk
cd dosbox-0.74-3
DOSBOXVERSION=$(svn log | head -2 | awk '/^r/ { print $1 }')
./autogen.sh
eval ./configure --with-sdl-prefix=DEPENDENCIES_DIR $OPTIONS
make
mv src/dosbox $BUILD_DIR/dosbox
cd $BUILD_DIR

# Create App
curl -Ls -o DOSBox-0.74-3-3.dmg https://sourceforge.net/projects/dosbox/files/dosbox/0.74-3/DOSBox-0.74-3-3.dmg/download
hdiutil attach DOSBox-0.74-3-3.dmg -quiet
cp -R /Volumes/DOSBox\ 0.74-3-3/DOSBox.app .
hdiutil detach /Volumes/DOSBox\ 0.74-3-3/ -quiet
mv dosbox DOSBox.app/Contents/MacOS/DOSBox

/usr/libexec/PlistBuddy -c "Set :CFBundleGetInfoString ${DOSBOXVERSION}, $COPYRIGHT_TEXT" DOSBox.app/Contents/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $DOSBOXVERSION" DOSBox.app/Contents/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $DOSBOXVERSION" DOSBox.app/Contents/Info.plist
/usr/libexec/PlistBuddy -c "Set :NSHumanReadableCopyright $COPYRIGHT_TEXT" DOSBox.app/Contents/Info.plist

# Cleanup
rm -rf dosbox-src
rm DOSBox-0.74-3-3.dmg

echo "Successfully built DOSBox from SVN revision $DOSBOXVERSION $BUILD_DIR/DOSBox.app"
