cask "cadente" do
  version "1.1.0-beta.124"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "fd9ae37fcec8043b8a7f7c08665fd66e703b86e61fbd905703df7df3a4024770"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "fbb4b8eabaf04571d2247bf365feaff7a8bcd7a3168aaf4d678f3aa894115829"
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
