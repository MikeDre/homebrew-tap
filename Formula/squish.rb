class Squish < Formula
  desc "Super fast local file optimisation: images, video, audio, and code"
  homepage "https://github.com/MikeDre/squish"
  version "0.8.0"
  license "MIT"

  # dav1d and libheif are linked at load time (HEIC/AVIF support); ffmpeg and
  # gifsicle are runtime subprocess dependencies for video/audio and GIF.
  depends_on "dav1d"
  depends_on "ffmpeg"
  depends_on "gifsicle"
  depends_on "libheif"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MikeDre/squish/releases/download/v0.8.0/squish-v0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "667ad5e0353513a1d2c29fe9d1dc628fc6d3e4d58d62ddc1addff84bfd9f1ebc"
    else
      url "https://github.com/MikeDre/squish/releases/download/v0.8.0/squish-v0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "c5a92e6cdd8e2a8efdf8245d0c9d3ea0deb68cfd92ac32e24d99f07693b2a733"
    end
  end

  def install
    bin.install "squish"
    man1.install "squish.1"
    generate_completions_from_executable(bin/"squish", "completions")
  end

  def caveats
    <<~EOS
      To add the "Right-click → Squish" Finder Quick Action, run:
        squish finder-action install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/squish --version")
  end
end
