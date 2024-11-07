EAPI=8
inherit git-r3 systemd

DESCRIPTION="ChimeraOS session on Gamescope - Own personal repository, issues and forks should be made on ChimeraOS/gamescope-session"
HOMEPAGE="https://github.com/ChimeraOS/gamescope-session"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ChimeraOS/gamescope-session.git"
LICENSE="MIT"

SLOT="0"
IUSE="systemd"
RDEPEND="systemd? sys-apps/systemd"
DEPEND="${RDEPEND}"

src_install() {
	if use systemd; then
		systemd_douserunit "${S}/usr/lib/systemd/user/gamescope-session-plus@.service"
	fi
	dobin "${S}/usr/bin/export-gpu"
	dobin "${S}/usr/bin/gamescope-session-plus"
	insinto "/usr/libexec"
	insopts -m 755
	doins "${S}/usr/libexec/gamescope-sdl-workaround"
	insinto "/usr/share/gamescope-session-plus"
	doins "${S}/usr/share/gamescope-session-plus/gamescope-session-plus"
	insopts -m 644
	doins "${S}/usr/share/gamescope-session-plus/device-quirks"

	default
}

pkg_postinst() {
	elog "This package alone does not provide any user sessions."
	elog "Instead, this package provides common files used by"
	elog "actual user sessions, such as gamescope-session-steam"
	if ! use systemd; then
		elog
		elog "Upstream provides a Systemd user unit for use by sessions."
		elog "As I have no experience writing user services for OpenRC"
		elog "and am not currently running OpenRC myself, I have not provided"
		elog "a service."
		elog "Without knowing how a session uses the upstream unit, I cannot"
		elog "know how a session will react to the absence of that unit."
}
