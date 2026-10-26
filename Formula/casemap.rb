class Casemap < Formula
  desc "The living map of your app's use cases: check, render and diff Mermaid flows"
  homepage "https://github.com/Ross-cripto/casemap"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Ross-cripto/casemap/releases/download/v0.5.0/casemap-aarch64-apple-darwin.tar.xz"
      sha256 "327c8f7c2b1386d7bb2ab8d238a36d93b3db73572da61285e4c3d50374777bfd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Ross-cripto/casemap/releases/download/v0.5.0/casemap-x86_64-apple-darwin.tar.xz"
      sha256 "773b4031234aa120529db111dd92aad1a45f2a639cc92c50926d746bc2f7fab2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Ross-cripto/casemap/releases/download/v0.5.0/casemap-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bdda2c6aa67eb6f640c74dca1619e48212e1b9dbad82a4c1a2d664c83dd3c1c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Ross-cripto/casemap/releases/download/v0.5.0/casemap-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7757d6e65f090551e347e5feec7096ba0016b216f6e61f12a42cdfe0f726cf15"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "casemap"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "casemap"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "casemap"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "casemap"
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
