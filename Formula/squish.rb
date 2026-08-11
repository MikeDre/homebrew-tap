class Squish < Formula
  desc "Super fast local file optimisation: images, video, audio, and code"
  homepage "https://github.com/MikeDre/squish"
  version "0.10.1"
  license "MIT"

  # dav1d and libheif are linked at load time (HEIC/AVIF support); ffmpeg and
  # gifsicle are runtime subprocess dependencies for video/audio and GIF.
  depends_on "dav1d"
  depends_on "ffmpeg"
  depends_on "gifsicle"
  depends_on "libheif"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MikeDre/squish/releases/download/v0.10.1/squish-v0.10.1-aarch64-apple-darwin.tar.gz"
      sha256 "b38cd443e4004bcadf2da986a979d604a5fd77c12e9b280c7ce33c1cd331397d"
    else
      url "https://github.com/MikeDre/squish/releases/download/v0.10.1/squish-v0.10.1-x86_64-apple-darwin.tar.gz"
      sha256 "880c4d38fea42ae2df980ebce49cb2a2e5c9984cb1884c1725691c48ec3f1f69"
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
