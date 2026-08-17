cask "solus" do
  version "0.24.0"
  sha256 "b3c7c96c7ce89a1cb65b5bd6dc69e3a2c469f58bfb12f90858bb44004c5121dc"

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
