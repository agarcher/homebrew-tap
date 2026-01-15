# typed: false
# frozen_string_literal: true

class Wt < Formula
  desc "Git worktree manager with lifecycle hooks"
  homepage "https://github.com/agarcher/wt"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.4.0/wt-darwin-amd64.tar.gz"
      sha256 "eaf70609f50b51ecd913f720aca495716aec28752bfa4c30a59bf69c5298ab67"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.4.0/wt-darwin-arm64.tar.gz"
      sha256 "1dbda7b246786c7bbfcba5f63e4c725b053c6170c8a8fbdfd000b5eb9a0d0090"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.4.0/wt-linux-amd64.tar.gz"
      sha256 "3d79d8c75a4ea6134a1c67cf8713bf093d415cd408256c57eb074de60d40fa56"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.4.0/wt-linux-arm64.tar.gz"
      sha256 "7dfa9a770a96c5e81131fc86b8f7155c12e1c5e76533956f0b771a47671e6ac6"
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
