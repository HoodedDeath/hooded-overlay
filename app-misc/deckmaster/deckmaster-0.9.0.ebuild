EAPI=8

inherit go-module udev

DESCRIPTION="An application to control your Elgato Stream Deck on Linux"
HOMEPAGE="https://github.com/muesli/deckmaster"
SRC_URI="
	https://github.com/muesli/deckmaster/archive/refs/tags/v0.9.0.tar.gz -> ${P}.tar.gz
	https://github.com/HoodedDeath/hooded-overlay/releases/download/deckmaster-0.9.0-vendor/deckmaster-0.9.0-vendor.tar.xz
"

LICENSE="
	MIT
	BSD-3
	BSD-2
	WTFPL
	ISC
	Apache-2.0
"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="systemd udev-uinput-rules" # USE +systemd installs example service files into /usr/share/deckmaster, +udev-uinput-rules to install a udev rules file to allow the group 'input' write access to /dev/uinput (add user to input group for ability to emulate input devices)
RDEPEND="virtual/udev media-fonts/roboto"
BDEPEND="virtual/udev dev-lang/go app-alternatives/gzip dev-vcs/git"
DEPEND="${RDEPEND}"
RESTRICT="strip"

src_compile() {
  export CGO_CPPFLAGS="${CPPFLAGS}"
  export CGO_CFLAGS="${CFLAGS}"
  export CGO_CXXFLAGS="${CXXFLAGS}"
  export CGO_LDFLAGS="${LDFLAGS}"

  local commit
  local extraflags
  commit=$(zcat "${DISTDIR}/${P}.tar.gz" | git get-tar-commit-id)
  extraflags="-X main.Version=${PV} -X main.CommitSHA=${commit}"

	ego build \
		-trimpath \
		-buildmode=pie \
		-ldflags "${extraflags} -extldflags \"${LDFLAGS}\"" \
		-o "${PN}" .
}

src_install() {
	dobin deckmaster
	udev_dorules "${FILESDIR}/99-streamdeck.rules"
	if use systemd; then
		insinto /usr/share/${PN}
		doins "${FILESDIR}/example-streamdeck.service"
		doins "${FILESDIR}/example-streamdeck.path"
	fi
	if use udev-uinput-rules; then
		udev_dorules "${FILESDIR}/98-uinput-permissions.rules"
	fi
	default
}

pkg_postinst() {
	if use systemd; then
		elog "Example systemd service and path files have been installed to /usr/share/${PN}"
		elog "These files should be modified to point to the correct device and layout file, then installed as user services"
		elog
	fi
	if use udev-uinput-rules; then
		elog "Make sure to add your user to the 'input' group to allow for emulating input devices on your Stream Deck"
		elog
	else
		elog "With USE -udev-uinput-rules, Deckmaster will not for sure be able to emulate input devices / key presses."
		elog "If you'd like to use that feature, either enable that USE flag, or otherwise ensure your user can write to /dev/uinput"
		elog
	fi
}
