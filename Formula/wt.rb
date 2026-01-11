# typed: false
# frozen_string_literal: true

class Wt < Formula
  desc "Git worktree manager with lifecycle hooks"
  homepage "https://github.com/agarcher/wt"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.1.0/wt-darwin-amd64.tar.gz"
      sha256 "2c09553810552b9ca8785462fc2ae1de73dd43ec4df9c109970110f5cd60a15f"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.1.0/wt-darwin-arm64.tar.gz"
      sha256 "c3778b44e9d684ecc4ade4130fcc6fa3c85d7238ddff918e97ef0b403b3fe65b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.1.0/wt-linux-amd64.tar.gz"
      sha256 "5a58ea2b289c88434154df114fe9a1123fcda5a3e2ccfd5af5c1f569a2d7b852"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.1.0/wt-linux-arm64.tar.gz"
      sha256 "38e267c98cb7c6515a34fdb7b1f5dffaef7329617d57a03059e36ea02a5e848c"
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
