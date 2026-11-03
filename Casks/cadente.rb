cask "cadente" do
  version "1.1.0-beta.13"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "5c228ba86a9df94b2c5d64ce9bbcc57fc2a50513aa63de71702b362f50622002"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "8713d11e9d35779da9b7fef7bb28469c636f0666c97a7ae3dea357b975304e88"
  end

  name "Cadente"
  desc "AI-powered desktop assistant — chat, terminal, Git and more"
  homepage "https://cadente-hub.github.io"

  auto_updates true
  depends_on macos: ">= :big_sur"

  app "Cadente.app"

  # Unsigned app: drop the quarantine flag and sign ad-hoc so it opens without the "is damaged" error.
  postflight do
    system_command "/usr/bin/xattr",
         args: ["-cr", "#{appdir}/Cadente.app"],
         sudo: true
    system_command "/usr/bin/codesign",
         args: ["--force", "--deep", "--sign", "-", "#{appdir}/Cadente.app"],
         sudo: true
  end

  zap trash: [
    "~/Library/Application Support/com.cadente.app",
    "~/Library/Caches/com.cadente.app",
    "~/Library/Preferences/com.cadente.app.plist",
    "~/Library/Saved Application State/com.cadente.app.savedState",
  ]
end
