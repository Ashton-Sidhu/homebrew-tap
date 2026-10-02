cask "solus" do
  version "0.35.2"
  sha256 "149c707a6976490fd75b17e765114ad00988597d52faca9844fa7f6ae06ae0c5"

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
