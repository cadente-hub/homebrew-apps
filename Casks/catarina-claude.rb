cask "catarina-claude" do
  version "0.1.2"

  if Hardware::CPU.arm?
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-arm64.dmg"
    sha256 :no_check
  else
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-x64.dmg"
    sha256 :no_check
  end

  name "Catarina Claude"
  desc "AI-powered desktop assistant — chat, terminal, Git, API testing, and more"
  homepage "https://catarina-claude.github.io"

  livecheck do
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/latest"
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Catarina Claude.app"

  zap trash: [
    "~/Library/Application Support/com.catarina-claude.app",
    "~/Library/Caches/com.catarina-claude.app",
    "~/Library/Preferences/com.catarina-claude.app.plist",
    "~/Library/Saved Application State/com.catarina-claude.app.savedState",
  ]
end
