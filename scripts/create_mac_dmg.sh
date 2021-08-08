#!/bin/sh
test -f yggy.dmg && rm yggy.dmg
create-dmg \
  --volname "Yggy Installer" \
  --volicon "./assets/yggy.icns" \
  --background "./assets/dmg_background.png" \
  --window-pos 200 120 \
  --window-size 800 530 \
  --icon-size 130 \
  --text-size 14 \
  --icon "yggy.app" 260 250 \
  --hide-extension "yggy.app" \
  --app-drop-link 540 250 \
  --hdiutil-quiet \
  "build/macos/Build/Products/Release/yggy.dmg" \
  "build/macos/Build/Products/Release/yggy.app"
