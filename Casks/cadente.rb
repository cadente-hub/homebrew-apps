cask "cadente" do
  version "1.1.0-beta.35"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "27c0176f8ede7dcdff18bd30aef4ae35ceece01fe8ffbe820a5efeb9be870c93"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "f11f871d657e4372b1695424500bf2e5e7439c4c5ff0ee596ea1133b595109ed"
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
