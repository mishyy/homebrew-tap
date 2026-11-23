class Utpm < Formula
  desc "Unofficial Typst Package Manager"
  homepage "https://github.com/typst-community/utpm"
  url "https://github.com/typst-community/utpm/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "c94c495cb2c2d68ef158d6a5d1f1e52475bd14e2ba9382713d121e2b53c9ae7c"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "openssl@4"
  end

  def install
    # Upstream forces `target-cpu=native`, which is not portable in bottles
    rm ".cargo/config.toml"

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
