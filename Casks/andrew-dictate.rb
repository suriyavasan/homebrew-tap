cask "andrew-dictate" do
  version "0.15.0"
  sha256 "21fe20a0b148d18cd457335cdcdd03c6dcecd0162dd1eebc1a1370a107f792dd"

  url "https://github.com/suriyavasan/andrew-dictate/releases/download/suriya-#{version}/AndrewDictate-#{version}.dmg"
  name "Andrew Dictate"
  desc "Dictation and meeting transcripts for talking to AI agents (suriyavasan fork)"
  homepage "https://github.com/suriyavasan/andrew-dictate"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "Andrew Dictate.app"

  caveats <<~EOS
    andrew dictate is not notarized. clear the quarantine once, then open it:
      xattr -dr com.apple.quarantine "/Applications/Andrew Dictate.app"
      open "/Applications/Andrew Dictate.app"

    setup downloads the speech models for the jobs you tick:
    dictation is ~460 mb, meeting recording is ~2.9 gb.

    the in-app "update to …" line follows jassuwu/tap; update this fork with:
      brew upgrade --cask suriyavasan/tap/andrew-dictate
  EOS

  zap trash: [
    "~/Library/Application Support/Andrew Dictate",
  ]
end
