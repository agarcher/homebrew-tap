# typed: false
# frozen_string_literal: true

class Wt < Formula
  desc "Git worktree manager with lifecycle hooks"
  homepage "https://github.com/agarcher/wt"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.2.0/wt-darwin-amd64.tar.gz"
      sha256 "62bf7183b0f8a10eedbc560030cd0574aefa9e04cb1d9976837eafd155a9c7a3"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.2.0/wt-darwin-arm64.tar.gz"
      sha256 "c51ea4c7a6d40360e1b0e330fdab6705152e40e5bca9b6631a19b26338ae58ea"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.2.0/wt-linux-amd64.tar.gz"
      sha256 "81b153fe39413a4979d9cc66c76fa66ec65b7a87369d1ce6c6025ebbfa3910d4"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.2.0/wt-linux-arm64.tar.gz"
      sha256 "8685719e8fb2aef96569bd287fcd74a4df6652cc1a05b644276b77048336408e"
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
