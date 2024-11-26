# Ported from the PKGBUILD for https://aur.archlinux.org/packages/wol-systemd

EAPI=8

inherit systemd

DESCRIPTION="A systemd unit file for enabling Wake-On-LAN automatically"
HOMEPAGE="https://wiki.archlinux.org/title/Wake-on-LAN"

KEYWORDS="~amd64"
LICENSE="FDL-1.3"
SLOT="0"
IUSE="systemd"
REQUIRED_USE="systemd"

RDEPEND="sys-apps/ethtool"
DEPEND="${RDEPEND}"

src_unpack() {
  # Trick the ebuild into working. We don't have any source files except the one service file
  mkdir -p "${S}"
}

src_install() {
  systemd_newunit "${FILESDIR}/wol@.service" "wol@.service"
}

pkg_postinst() {
  elog "Now you may enable WOL on each boot with:"
  elog "  systemctl enable wol@<interface>.service"
  elog ""
  elog "If you wish to have WOL enabled once, simply call:"
  elog "  systemctl start wol@<interface>.service"
}
