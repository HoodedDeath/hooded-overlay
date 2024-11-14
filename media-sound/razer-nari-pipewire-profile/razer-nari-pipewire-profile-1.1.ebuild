EAPI=8

inherit udev

DESCRIPTION="PipeWire profile for Razer Nari"
HOMEPAGE="https://github.com/mrquantumoff/razer-nari-pipewire-profile"
SRC_URI="https://github.com/mrquantumoff/razer-nari-pipewire-profile/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="media-video/pipewire[sound-server] virtual/udev"

src_install() {
	insinto /usr/share/alsa-card-profile/mixer/paths
	doins "${S}"/razer-nari-input.conf
	doins "${S}"/razer-nari-output-game.conf
	doins "${S}"/razer-nari-output-chat.conf
	insinto /usr/share/alsa-card-profile/mixer/profile-sets
	doins "${S}"/razer-nari-usb-audio.conf
	udev_dorules "${S}"/91-pulseaudio-razer-nari.rules
}
