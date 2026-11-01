class Pixelfold < Formula
  desc "Terminal protein structure viewer and residue interaction network engine"
  homepage "https://github.com/fuyu-myk/pixelfold"
  version "4.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v4.0.0/pixelfold-aarch64-apple-darwin.tar.xz"
      sha256 "0f5c8e034a239f1f44536612a00863ec77123fa7a575d8fc61046c47e7e582c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v4.0.0/pixelfold-x86_64-apple-darwin.tar.xz"
      sha256 "846794977bedb613db64404eea7e3a45159eed18bd4a06b2851b381b5121d4e5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v4.0.0/pixelfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ce84b0dd9a8524e7e3e6d1f6dc6fb0b4c5cca4771fc9dcd8e738f5722df50b8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v4.0.0/pixelfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ebd9dd035be1bd181246e77a6cba92d2dc0313d289f965349565a44ea6d9ae7"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pixelfold"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pixelfold"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pixelfold"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pixelfold"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
