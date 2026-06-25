# homebrew-lockin

Homebrew tap for [LockIn](https://github.com/HumbleBee14/LockIn) — a macOS focus blocker
that hard-locks distracting sites and apps on a recurring schedule.

## Install

```sh
brew tap humblebee14/lockin
brew install --cask lockin
```

Or do it in one line without tapping first:

```sh
brew install --cask humblebee14/lockin/lockin
```

## Upgrade

```sh
brew upgrade --cask lockin
```

## Uninstall

LockIn installs a privileged background helper. **Before** removing the app, open LockIn
and use **Settings → Uninstall** (available only when no lock is active) to remove the
system helpers and reset your hosts file. Then:

```sh
brew uninstall --cask lockin
brew uninstall --zap --cask lockin   # also removes ~/Library leftovers
```

## Maintainer: cutting a release

The cask is updated automatically by CI when a new `v*` release is published on the main
repo (see `.github/workflows/`). To update it by hand:

```sh
./scripts/update-cask.sh 1.0.0
git commit -am "lockin 1.0.0" && git push
```
