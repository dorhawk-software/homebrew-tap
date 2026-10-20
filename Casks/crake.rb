# Crake's Homebrew cask, filled in by the release workflow (version, the
# package's checksum) and pushed to dorhawk-software/homebrew-tap:
#   brew install --cask dorhawk-software/tap/crake
cask "crake" do
  version "0.12.0"
  sha256 "d6fb2e40239128b4971e9cd8f67b78fe5d20d212c1eac11ca6e7ac160bb1649f"

  url "https://github.com/dorhawk-software/crake/releases/download/v#{version}/Crake-#{version}.pkg"
  name "Crake"
  desc "VPN client that sends only the hosts that need it through a tunnel"
  homepage "https://dorhawk.software/crake/"

  depends_on macos: ">= :monterey"
  depends_on formula: "openconnect"
  # OpenVPN profiles (craked runs Homebrew's openvpn).
  depends_on formula: "openvpn"

  pkg "Crake-#{version}.pkg"

  # craked stops first: switching every tunnel off takes its routes, DNS
  # settings and pf rules with it.
  uninstall launchctl: ["software.dorhawk.crake.daemon", "software.dorhawk.craked"],
            pkgutil:   "software.dorhawk.crake",
            delete:    "/Applications/Crake.app"

  zap trash: [
    "/var/db/crake",
    "/var/log/craked.log",
    "~/.local/state/crake",
  ]
end
