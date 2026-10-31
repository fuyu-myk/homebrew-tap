class Pixelfold < Formula
  desc "Terminal protein structure viewer and residue interaction network engine"
  homepage "https://github.com/fuyu-myk/pixelfold"
  version "3.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v3.0.0/pixelfold-aarch64-apple-darwin.tar.xz"
      sha256 "4167d3d18ce6947ec6dac2a24e6a9b9ce9331cf04753a36f9eb83063eb49ae19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v3.0.0/pixelfold-x86_64-apple-darwin.tar.xz"
      sha256 "df517c6f96084db0f286ce282eb67bf9f4c19a004acf6528621e9c39348beebb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v3.0.0/pixelfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9e08d870440d91459c8bca613d913987d66ab0e35a0dbac0e1351c096747ade5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v3.0.0/pixelfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f7be8c1067f243470e46c95b50472a7ccf53615cb2dceccef6f792946f98adb9"
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
