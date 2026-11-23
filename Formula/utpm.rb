class Utpm < Formula
  desc "Unofficial Typst Package Manager"
  homepage "https://github.com/typst-community/utpm"
  url "https://github.com/typst-community/utpm/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "141da3a9c265931fcd5594cdd7f60b7bab05e63d6f58dd4fa042fa3ef91fb684"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")

    # Generate and install shell completions
    generate_completions_from_executable(bin/"utpm", "generate")

    # Install documentation
    doc.install "docs/GUIDE.md"
  end

  test do
    assert_match "utpm", shell_output("#{bin}/utpm --version")
  end
end
