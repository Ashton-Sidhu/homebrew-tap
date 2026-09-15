cask "solus" do
  version "0.32.1"
  sha256 "5b16cb19f5d36702f857715aa81f47b6558fd6294b150b8aff327b5618de08a5"

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
