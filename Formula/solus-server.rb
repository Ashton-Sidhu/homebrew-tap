# typed: false
# frozen_string_literal: true

class SolusServer < Formula
  desc "CLI and self-hosted daemon for coding agents"
  homepage "https://solus.sh/"
  license "BUSL-1.1"

  on_macos do
    on_arm do
      url "https://github.com/Ashton-Sidhu/solus/releases/download/v0.19.1/solus-server-darwin-arm64.tar.gz"
      sha256 "891d9921a92e9642bc6e62db47f0c6983ab8be1a325de873db513087d82252be" # target: darwin-arm64
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ashton-Sidhu/solus/releases/download/v0.19.1/solus-server-linux-x64.tar.gz"
      sha256 "87f4085d48115205f05cfa7a59acd542aabd49733ef9e97de7e81685115c7d3d" # target: linux-x64
    end
    on_arm do
      url "https://github.com/Ashton-Sidhu/solus/releases/download/v0.19.1/solus-server-linux-arm64.tar.gz"
      sha256 "cc906480843b33bdd68bef58b2dc37077ef0e95ddd7aa5c96ae29a7922a4cd2d" # target: linux-arm64
    end
  end

  def install
    libexec.install Dir["*"]

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
    environment_variables SOLUS_DATA_DIR: "#{Dir.home}/.solus"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/solus --version")
  end
end
