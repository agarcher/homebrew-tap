# typed: false
# frozen_string_literal: true

class Wt < Formula
  desc "Git worktree manager with lifecycle hooks"
  homepage "https://github.com/agarcher/wt"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.3.0/wt-darwin-amd64.tar.gz"
      sha256 "53ae1ffcd146ef19b97a22e3a35055265fac17cbc6b8bd7e704a6e5d5f77390d"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.3.0/wt-darwin-arm64.tar.gz"
      sha256 "076dc74d32b6c8e43cb664e727d53af8a865b1997c557f596152ef8d18af9c6c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.3.0/wt-linux-amd64.tar.gz"
      sha256 "67091c39c484a32609b773e51af62bf8c6559ce8a4ad13c3d2697932287ce102"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.3.0/wt-linux-arm64.tar.gz"
      sha256 "2fc1f9ef78d9f1677f1592c6e0c1f0e95e7d684e12f5673bf151424887352c15"
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
