class Squish < Formula
  desc "Super fast local file optimisation: images, video, audio, and code"
  homepage "https://github.com/MikeDre/squish"
  version "0.5.0"
  license "MIT"

  # dav1d and libheif are linked at load time (HEIC/AVIF support); ffmpeg and
  # gifsicle are runtime subprocess dependencies for video/audio and GIF.
  depends_on "dav1d"
  depends_on "ffmpeg"
  depends_on "gifsicle"
  depends_on "libheif"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MikeDre/squish/releases/download/v0.5.0/squish-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "009eac33efae8facaeae54ab7785236879fd69f1f401ebee3cff1cd4e49821aa"
    else
      url "https://github.com/MikeDre/squish/releases/download/v0.5.0/squish-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "6437c8a149f86f5ec4901ff88a31d360a5fd13aa71c2e979c9b9840c23f75ed4"
    end
  end

  def install
    bin.install "squish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/squish --version")
  end
end
