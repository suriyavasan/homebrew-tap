cask "andrew-dictate" do
  version "0.14.1"
  sha256 "4e6c4cbee85e5f8eefb98a99b5d2e04b166fe485edc60f24ebb26b5349c590e9"

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
