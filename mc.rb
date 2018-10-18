class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2018-10-18T00-40-05Z"

  desc "ls, cp, mkdir, diff and rsync for filesystems and object storage"
  homepage "https://github.com/minio/mc"
  url "https://github.com/minio/mc.git"
  version git_tag.gsub(%r'[^\d]+', '') + 'Z'
  revision 1

  if OS.mac?
    url "https://dl.minio.io/client/mc/release/darwin-amd64/mc.#{git_tag}"
    sha256 "2b55061b54df29d127e6d9d7f2adc5268ae73adbaf3888251dd5cbd954308e9c"
  elsif OS.linux?
    raise "No Linux support"
  end

  bottle :unneeded
  depends_on :arch => :x86_64

  conflicts_with "midnight-commander", :because => "Both install a `mc` binary"

  def install
    bin.install Dir.glob("mc.*").first => "mc"
  end

  def post_install
    (etc/"mc").mkpath
  end

  test do
    system bin/"mc", "mb", testpath/"test"
    assert File.exist?(testpath/"test")
  end
end
