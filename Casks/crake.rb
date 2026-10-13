# Crake's Homebrew cask, filled in by the release workflow (version, the
# package's checksum) and pushed to dorhawk-software/homebrew-tap:
#   brew install --cask dorhawk-software/tap/crake
cask "crake" do
  version "0.5.0"
  sha256 "2badbb268109f9c6e798646191ed075774959e7c0bd76a8e05917f7d4dced4c0"

  url "https://github.com/dorhawk-software/crake/releases/download/v#{version}/Crake-#{version}.pkg"
  name "Crake"
  desc "VPN client that sends only the hosts that need it through a tunnel"
  homepage "https://dorhawk.software/crake/"

  depends_on macos: ">= :monterey"
  depends_on formula: "openconnect"

  pkg "Crake-#{version}.pkg"

  # craked stops first: switching every tunnel off takes its routes, DNS
  # settings and pf rules with it.
  uninstall launchctl: "software.dorhawk.craked",
            pkgutil:   "software.dorhawk.crake",
            delete:    "/Applications/Crake.app"

  zap trash: [
    "/var/db/crake",
    "/var/log/craked.log",
    "~/.local/state/crake",
  ]
end
