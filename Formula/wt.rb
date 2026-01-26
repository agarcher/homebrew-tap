# typed: false
# frozen_string_literal: true

class Wt < Formula
  desc "Git worktree manager with lifecycle hooks"
  homepage "https://github.com/agarcher/wt"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.4.2/wt-darwin-amd64.tar.gz"
      sha256 "45551a05862df09fdae87aa98554bc5c02398b45c8c52ef9d76b3146f5c248dd"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.4.2/wt-darwin-arm64.tar.gz"
      sha256 "2ad75579a0838516312b5b860572a909b7f7141dd73cf3882ea361bab87031af"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agarcher/wt/releases/download/v0.4.2/wt-linux-amd64.tar.gz"
      sha256 "652c98935ebf2434de1438bb002b6209e230ce0e2d756267eaeebf672b7f315c"
    end

    on_arm do
      url "https://github.com/agarcher/wt/releases/download/v0.4.2/wt-linux-arm64.tar.gz"
      sha256 "5c9e3148c24bb77b61ee1a79d264e6b98f935b5e7422afd97438534615d8cbcf"
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
