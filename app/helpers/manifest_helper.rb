module ManifestHelper
  class << self 
    def gen_manifest(app_version)
      text = ''
      text += '<?xml version="1.0" encoding="UTF-8"?>'
      text += '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'
      text += '<plist version="1.0">'
      text += '  <dict>'
      text += '    <key>items</key>'
      text += '    <array>'
      text += '      <dict>'
      text += '        <key>assets</key>'
      text += '        <array>'
      text += '          <dict>'
      text += '            <key>kind</key>'
      text += '            <string>software-package</string>'
      text += '            <key>url</key>'
      text += '            <string>http://localhost/tot/Documents/com.netease.cloudmusic/1/BetaTest.ipa</string>'
      text += '          </dict>'
      text += '        </array>'
      text += '        <key>metadata</key>'
      text += '        <dict>'
      text += '          <key>bundle-identifier</key>'
      text += '          <string>com.netease.cloudmusic</string>'
      text += '          <key>bundle-version</key>'
      text += '          <string>1.4.0 (1.4.0)</string>'
      text += '          <key>kind</key>'
      text += '          <string>software</string>'
      text += '          <key>title</key>'
      text += '          <string>网易云音乐</string>'
      text += '        </dict>'
      text += '      </dict>'
      text += '    </array>'
      text += '  </dict>'
      text += '</plist>'
      return text
    end
  end
end
