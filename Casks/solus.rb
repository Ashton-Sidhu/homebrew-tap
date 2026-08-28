cask "solus" do
  version "0.26.4"
  sha256 "bea09838fab05252ac5c46f29356bf96253f3859dbb6c50d606e9675d306616b"

  url "https://github.com/Ashton-Sidhu/solus/releases/download/v#{version}/Solus-#{version}-arm64.dmg"
  name "Solus"
  desc "Keyboard-first interface for coding agents"
  homepage "https://solus.sh/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Solus.app"

  zap trash: [
    "~/.solus",
    "~/Library/Application Support/Solus",
    "~/Library/Caches/com.solus.app",
    "~/Library/Preferences/com.solus.app.plist",
    "~/Library/Saved Application State/com.solus.app.savedState",
  ]
end
