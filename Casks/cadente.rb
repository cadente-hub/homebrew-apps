cask "cadente" do
  version "0.2.66"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "3b4a4328ecfb22a2cd94dbd52124c563d5b6f3f7e7affef47db584292cb5a7c7"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "21ad2de6b3f0a09bb500b34032a3ec75f4259980ec998082bc6747a3fe9b274f"
  end

  name "Cadente"
  desc "AI-powered desktop assistant — chat, terminal, Git, API testing, and more"
  homepage "https://cadente-hub.github.io"

  livecheck do
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/latest"
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Cadente.app"

  # Strip macOS quarantine + re-sign ad-hoc locally so the app opens without
  # "is damaged" Gatekeeper error. Required for unsigned apps — robust on both
  # Intel and Apple Silicon (M1–M4) regardless of original signature state.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Cadente.app"],
                   sudo: true
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Cadente.app"],
                   sudo: true
    system_command "/usr/bin/open",
                   args: ["#{appdir}/Cadente.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.cadente.app",
    "~/Library/Caches/com.cadente.app",
    "~/Library/Preferences/com.cadente.app.plist",
    "~/Library/Saved Application State/com.cadente.app.savedState",
  ]
end
