cask "cadente" do
  version "1.1.0-beta.39"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "7d844a41eaa7ff09770c9d9f2cf44963155b275cb4863287938676290c702280"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "b9263ef6f6fde14395b3f85ab5ede3bff6ddea66a50820ef1c815bc1387e8be9"
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
