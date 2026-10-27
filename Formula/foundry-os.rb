# Generated from packaging/homebrew/foundry-os.rb.tmpl in github.com/suriyavasan/foundry-os by
# packaging/homebrew/render_formula.sh (version, URLs and SHA-256 come from the release's SHA256SUMS).
# Do not edit by hand: change the template.
class FoundryOs < Formula
  desc "Self-hosted operating system for an autonomous company of AI agents"
  homepage "https://github.com/suriyavasan/foundry-os"
  version "0.1.4"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    # Apple Silicon only: upstream libraries no longer ship Intel macOS builds. Intel Macs: use Docker.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/suriyavasan/foundry-os/releases/download/v0.1.4/foundry-os-0.1.4-darwin-arm64.tar.gz", using: :nounzip
      sha256 "df11adf329564f8afdae8d39f63d266d569a6c97f7f49c20fc032ac35889646b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/suriyavasan/foundry-os/releases/download/v0.1.4/foundry-os-0.1.4-linux-arm64.tar.gz", using: :nounzip
      sha256 "6e67d8af7eca7283db922d167ff0bdf5819c1f1ff288bf05e1dddb28703789fd"
    end
    on_intel do
      url "https://github.com/suriyavasan/foundry-os/releases/download/v0.1.4/foundry-os-0.1.4-linux-x86_64.tar.gz", using: :nounzip
      sha256 "70e72dad956ee263e868ba9461dd713b0e4123e170f043e1ccc1b36666870edf"
    end
  end

  def install
    # Homebrew rewrites the install names of every Mach-O library it finds in the keg when this method
    # returns. The bundle's prebuilt Python extension modules (Rust/C wheels) have no header room for
    # the longer names, so brew would report "Failed to fix install linkage". The bundle therefore stays
    # a tarball here (`using: :nounzip`) and is unpacked by the post-install step below, which runs
    # after that rewrite. Once unpacked it is the self-contained release bundle (its own Python
    # interpreters, dependencies, agent runtime and web UI), reached through the launcher.
    libexec.install Dir["foundry-os-*.tar.gz"].first => "bundle.tar.gz"
    # the launcher does not exist yet (see above), and Homebrew prunes dangling symlinks: wrap it by path
    bin.write_exec_script libexec/"bin/foundryos", libexec/"bin/companyos"
  end

  post_install_steps do
    unless_path_exists "bin/foundryos", base: :libexec do
      run "/usr/bin/tar", args: ["-xzf", "{{libexec}}/bundle.tar.gz", "-C", "{{libexec}}", "--strip-components=1"]
      remove "bundle.tar.gz", base: :libexec
    end
  end

  service do
    run [opt_bin/"foundryos", "serve"]
    keep_alive true
    log_path var/"log/foundry-os.log"
    error_log_path var/"log/foundry-os.log"
    environment_variables PATH:               std_service_path_env,
                          FOUNDRYOS_RUN_MODE: "service",
                          FOUNDRYOS_LOG_FILE: var/"log/foundry-os.log"
  end

  def caveats
    <<~EOS
      Start Foundry AI OS and open it in your browser:
        foundryos

      Your data (database, secrets, files) lives in:
        macOS: ~/Library/Application Support/Foundry AI OS
        Linux: ${XDG_DATA_HOME:-~/.local/share}/foundry-os
      `brew uninstall foundry-os` leaves it in place; delete that folder to start over.

      Run it in the background and at login:
        brew services start foundry-os
      Update:
        brew upgrade foundry-os
    EOS
  end

  test do
    ENV["FOUNDRYOS_DATA_DIR"] = testpath/"data"
    assert_match version.to_s, shell_output("#{bin}/foundryos --version")
    assert_match "up", shell_output("#{bin}/foundryos --help")
  end
end
