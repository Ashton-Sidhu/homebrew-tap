cask "solus" do
  version "0.29.0"
  sha256 "da64faf2e8bbca6ac2921737727a870b989f95c0407d7bb7fbad6233d9656789"

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
