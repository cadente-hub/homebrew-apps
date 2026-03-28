cask "catarina-claude" do
  version "0.1.7"

  if Hardware::CPU.arm?
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-arm64.dmg"
    sha256 "124148c8c0357812671f74017e4a69558ea3deed9f5c1baf27e6408c923bff03"
  else
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-x64.dmg"
    sha256 "5446a6a99fb7fc3c5835a93251edf2b1b7310bc32427c4c3e5db62ed3769abe5"
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
