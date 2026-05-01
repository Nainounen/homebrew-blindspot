cask "blindspot" do
  version "1.0.1"
  sha256 "e2b6174ccccccc6c14a11c878991dc5f60a2f4a16b2dd1be8dedb55775d3b7ad"

  url "https://github.com/Nainounen/blind-spot/releases/download/v#{version}/BlindSpot-#{version}.dmg"
  name "BlindSpot"
  desc "AI answers for selected text — invisible to screen recorders"
  homepage "https://github.com/Nainounen/blind-spot"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "BlindSpot.app"

  postflight do
    system_command "/usr/bin/xattr",
         args: ["-cr", "#{appdir}/BlindSpot.app"],
         sudo: false
    system_command "/usr/bin/codesign",
         args: ["--force", "--deep", "--sign", "-", "#{appdir}/BlindSpot.app"],
         sudo: false
  end

  uninstall quit: "com.blindspot.app"

  zap trash: [
    "~/Library/Preferences/com.blindspot.app.plist",
    "~/Library/Application Support/BlindSpot",
    "~/.config/blind-spot",
  ]

  caveats <<~EOS
    BlindSpot is a menu-bar app — there's no Dock icon by design.
    Launch it once with:
      open -a BlindSpot

    Required permission on first launch:
      System Settings → Privacy & Security → Accessibility → enable BlindSpot

    To update: brew update && brew upgrade --cask blindspot
  EOS
end
