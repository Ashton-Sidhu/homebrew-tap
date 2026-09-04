# typed: false
# frozen_string_literal: true

# Homebrew formula for the Solus CLI + self-hosted daemon.
#
# This file is the source of truth that lives in the main repo. It is copied to
# `Formula/solus-server.rb` in the tap repo (Ashton-Sidhu/homebrew-tap) by the release
# workflow's auto-bump job, which also rewrites `version` and the per-target
# `sha256` values. See packaging/homebrew/README.md.
#
# The formula pours the prebuilt, per-arch server tarball published to GitHub
# Releases by scripts/package-server.ts. It intentionally does NOT
# `depends_on "node"`: the tarball vendors a pinned Node runtime (bin/node), and
# native modules are NODE_MODULE_VERSION-pinned, so a brew node upgrade would
# break them.
class SolusServer < Formula
  desc "Command line interface and self-hosted daemon for coding agents"
  homepage "https://solus.sh/"
  license "BUSL-1.1"

  on_macos do
    on_arm do
      url "https://github.com/Ashton-Sidhu/solus/releases/download/v0.29.2/solus-server-darwin-arm64.tar.gz"
      sha256 "5e4e27b50744408799de9f081b359f8a364c9aa4460cebbda933c231c6200883" # target: darwin-arm64
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ashton-Sidhu/solus/releases/download/v0.29.2/solus-server-linux-x64.tar.gz"
      sha256 "edc2e38759b99c15a72f19b91bd195f36da72efb7d005b33da2f75120becef56" # target: linux-x64
    end
    on_arm do
      url "https://github.com/Ashton-Sidhu/solus/releases/download/v0.29.2/solus-server-linux-arm64.tar.gz"
      sha256 "e3beed2c8dd4e85673d6237657cf8d1506c03061167d463b4b9cb4fb089c5dfe" # target: linux-arm64
    end
  end

  def install
    # The tarball contains `bin/` (node + launcher scripts) and `libexec/`
    # (bundled server, CLI, and web client). Keep the whole tree under libexec so
    # the vendored launchers resolve their own root via `$0`.
    libexec.install Dir["*"]

    # A plain `bin.install_symlink` cannot be used here: the vendored launcher
    # (libexec/bin/solus) locates its install root from `dirname "$0"`, so it
    # must run at its real path. Invoked through a Homebrew symlink, `$0` would
    # point at #{HOMEBREW_PREFIX}/bin and the launcher would look for node in the
    # wrong place. A thin wrapper that execs the real launcher preserves `$0`.
    (bin/"solus").write <<~SH
      #!/bin/sh
      exec "#{libexec}/bin/solus" "$@"
    SH
  end

  service do
    run [opt_libexec/"bin/solus-server"]
    keep_alive true
    log_path var/"log/solus.log"
    error_log_path var/"log/solus.log"
    # Share the CLI's default data dir (~/.solus) so `solus claim` / `solus
    # status` see the running daemon's lock and state. The daemon honors
    # SOLUS_DATA_DIR (src/main/server/auth.ts, settings.ts, platform/paths.ts).
    environment_variables SOLUS_DATA_DIR: "#{Dir.home}/.solus"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/solus --version")
  end
end
