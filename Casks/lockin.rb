cask "lockin" do
  version "1.3.3"
  sha256 "4682801972c8f9e747b948968f01badd6d1964ebcccdc27a3d2ccc2b832f5c40"

  url "https://github.com/HumbleBee14/LockIn/releases/download/v#{version}/LockIn.dmg"
  name "LockIn"
  desc "Focus blocker that hard-locks distracting sites and apps on a schedule"
  homepage "https://github.com/HumbleBee14/LockIn"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "LockIn.app"

  uninstall launchctl: [
              "com.humblebee.lockin.agent",
              "com.humblebee.lockin.daemon",
            ],
            quit:      "com.humblebee.lockin"

  zap trash: [
    "~/Library/Application Support/LockIn",
    "~/Library/Caches/com.humblebee.lockin",
    "~/Library/Preferences/com.humblebee.lockin.plist",
  ]

  caveats <<~EOS
    LockIn installs a privileged background helper to enforce blocks across all
    browsers and survive reboot. On first launch you'll be asked to approve it in
    System Settings → General → Login Items & Extensions.

    Because it installs a root daemon and a per-user agent, the regular
    `brew uninstall lockin` cannot remove those system files. Open LockIn and use
    Settings → Uninstall (only available when no lock is active) BEFORE removing
    the app, then run `brew uninstall lockin`.
  EOS
end
