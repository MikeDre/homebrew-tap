class Squish < Formula
  desc "Super fast local file optimisation: images, video, audio, and code"
  homepage "https://github.com/MikeDre/squish"
  version "0.10.0"
  license "MIT"

  # dav1d and libheif are linked at load time (HEIC/AVIF support); ffmpeg and
  # gifsicle are runtime subprocess dependencies for video/audio and GIF.
  depends_on "dav1d"
  depends_on "ffmpeg"
  depends_on "gifsicle"
  depends_on "libheif"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MikeDre/squish/releases/download/v0.10.0/squish-v0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "b797994f234cea6b92f44f9035f7bb5cd7d13dce9cd92ef6a422302e1f3cc884"
    else
      url "https://github.com/MikeDre/squish/releases/download/v0.10.0/squish-v0.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "fc7bab8a6b27c44394158aa2a0ef5ba24da28ea04c914c1288b92093dc12694d"
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
