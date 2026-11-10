cask "cadente" do
  version "1.1.0-beta.119"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "b5cebb25789171afccacb5af6d6f1f24a4b76064bc71a45cda003ce0021b0e4a"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "058123d1ada0257d7113888109955166b52b853eac9e1a9869a16bf0a51f952a"
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
