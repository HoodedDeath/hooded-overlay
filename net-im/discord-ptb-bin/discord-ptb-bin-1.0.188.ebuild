# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=${PN/-bin/}

inherit desktop linux-info pax-utils unpacker xdg

DESCRIPTION="All-in-one voice and text chat"
HOMEPAGE="https://discord.com/"
SRC_URI="https://dl-ptb.discordapp.net/apps/linux/${PV}/${MY_PN}-${PV}.deb"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror bindist"

# libXScrnSaver is used through dlopen (bug #825370)
RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/libxshmfence
	x11-libs/pango
"

QA_PREBUILT="
	opt/discord-ptb/updater_bootstrap
"

CONFIG_CHECK="~USER_NS"

src_install() {
	newicon usr/share/${MY_PN}/${MY_PN//-ptb}.png ${MY_PN}.png
	domenu usr/share/${MY_PN}/${MY_PN}.desktop

	insinto /opt/${MY_PN}
	doins -r usr/share/${MY_PN}/.
	fperms +x /opt/${MY_PN}/postinst.sh
	fperms +x /opt/${MY_PN}/updater_bootstrap
	dobin usr/bin/discord-ptb

	pax-mark -m "${ED}"/opt/${MY_PN}/${MY_PN}
}
