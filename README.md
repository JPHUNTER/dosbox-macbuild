# dosbox-macbuild
Script to build the ReelMagic fork DOSBox App for Mac OSX using SVN and Git including build dependencies.

Description
-----------
Downloads & builds
- autoconf
- automake
- SDL
- DOSBox

All dependencies are sandboxed to the build folder

Credits to Hexeract for the build instructions https://hexeract.wordpress.com/2016/09/10/building-dosbox-as-x64-binary-for-macos-sierra/

Thanks gs11 for the original script that this was forked from https://github.com/gs11/dosbox-macbuild

Finally huge thanks to jrdennisoss  for firing up the fork of DOSBox in order to run ReelMagic games. Noo one else has done this and with this we can finally play the ReelMagic version of Return to Zork and other ReelMagic titles too https://github.com/jrdennisoss/dosboxrm

Usage
-----
`buildDosbox.sh <architecture>`

Architecture can either be 32 (32-bit) or 64 (64-bit) (_Please note that the 64-bit version is currently much slower than the 32-bit version_)
