EAPI=8
inherit git-r3

DESCRIPTION="gamescope-session-steam"
HOMEPAGE="https://github.com/ChimeraOS/gamescope-session-steam"

SRC_URI=""
EGIT_REPO_URI="https://github.com/ChimeraOS/gamescope-session-steam.git"
LICENSE="MIT"

SLOT="0"
RDEPEND="
	gui-libs/gamescope-session[systemd]
	games-util/steam-launcher
"
DEPEND="${RDEPEND}"

# There's no typical build and install system, just installing files where they need to go
src_install() {
	arr=(jupiter-biosupdate steam-http-loader steamos-select-branch steamos-session-select steamos-update)
	for item in ${arr[@]}; do
		dobin "${S}/usr/bin/${item}"
	done
	insinto /usr
	doins -r "${S}/usr/share/"
	insinto /usr/bin
	insopts -m 755
	doins -r "${S}/usr/bin/steamos-polkit-helpers"
}
