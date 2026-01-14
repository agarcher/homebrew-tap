# typed: false
# frozen_string_literal: true

class Wt < Formula
  desc "Git worktree manager with lifecycle hooks"
  homepage "https://github.com/agarcher/wt"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.3.1/wt-darwin-amd64.tar.gz"
      sha256 "a21aca2a7a1578b9e53dd839635c942725dcec06a384417cc38dd8aac9626965"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.3.1/wt-darwin-arm64.tar.gz"
      sha256 "ce218c1bf3ab3cbcfab015ea86395d99b966909a2489978025715de9fec41d64"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.3.1/wt-linux-amd64.tar.gz"
      sha256 "65f481dda1946c8cd14694c1d4cf6ca58befbf6dfe1318c8f4ffb95bafd0732d"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.3.1/wt-linux-arm64.tar.gz"
      sha256 "faa257329a4194e8e47010b178a9fe1af436b93fc1adfd871a83735aed78e59e"
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
