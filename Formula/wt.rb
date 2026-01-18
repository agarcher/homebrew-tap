# typed: false
# frozen_string_literal: true

class Wt < Formula
  desc "Git worktree manager with lifecycle hooks"
  homepage "https://github.com/agarcher/wt"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.4.1/wt-darwin-amd64.tar.gz"
      sha256 "cbd74023dd686a99abc076d712a9a77042b80199e86180d960d6258b61a9a769"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.4.1/wt-darwin-arm64.tar.gz"
      sha256 "8345bcfab793341af8c047f208e23ce4a55549790f54727121ae3dc798c8d657"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.4.1/wt-linux-amd64.tar.gz"
      sha256 "5ce00bef00ee4c09fedd73ca2655bc11d26a47d7239adff9aeaf4ad1a715c5f0"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.4.1/wt-linux-arm64.tar.gz"
      sha256 "9c700d8846f2a9c94800d9d102b5124c7c97f03c171dfdb51cabcf92dad11f0b"
    end
  end

  def install
    arch = Hardware::CPU.intel? ? "amd64" : "arm64"
    binary_name = "wt-#{OS.kernel_name.downcase}-#{arch}"
    bin.install binary_name => "wt"

    generate_completions_from_executable(bin/"wt", "completion")
  end

  def caveats
    <<~EOS
      To enable wt shell integration, add the following to your shell config:

      For zsh (~/.zshrc):
        eval "$(wt init zsh)"

      For bash (~/.bashrc):
        eval "$(wt init bash)"

      For fish (~/.config/fish/config.fish):
        wt init fish | source
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wt version")
  end
end
