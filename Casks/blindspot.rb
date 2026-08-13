cask "blindspot" do
  version "2.4.2"
  sha256 "7c2a51f2b8a1ac2c28bc41cb31e20a53998e6237dc20bb8ec088c6f339d5e0a9"

  url "https://github.com/Nainounen/blind-spot/releases/download/v#{version}/BlindSpot-#{version}.dmg"
  name "BlindSpot"
  desc "AI answers for selected text — invisible to screen recorders"
  homepage "https://github.com/Nainounen/blind-spot"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :tahoe"

  app "BlindSpot.app"

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
