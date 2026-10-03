cask "lockin" do
  version "1.6.0"
  sha256 "2b513514af4bbf30da8ed9a5cd452e54c856c24bab49be324866fa1781800f74"

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

  # `launchctl:` kept out on purpose: Homebrew runs this stanza on `brew upgrade` too, and
  # stopping the root daemon mid-upgrade drops the lock screen, pauses app blocking, and forces
  # a re-approval in System Settings. The daemon survives the bundle swap and picks up the new
  # binary at next boot. Real removal goes through LockIn → Settings → Uninstall (see caveats).
  # uninstall launchctl: [
  #             "com.humblebee.lockin.agent",
  #             "com.humblebee.lockin.daemon",
  #           ],
  #           quit:      "com.humblebee.lockin"
  uninstall quit: "com.humblebee.lockin"

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
