cask "lockin" do
  version "1.3.14"
  sha256 "9c18dbfa70762babf48d6834fd9b11d820591512a0ef5352b1cba49792200fb8"

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
