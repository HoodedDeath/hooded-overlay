EAPI=8

inherit desktop xdg

DESCRIPTION="Sublime Merge is a most excellent git client"
HOMEPAGE="https://www.sublimemerge.com/"

MY_PN="${PN%-bin}"

SRC_URI="https://download.sublimetext.com/${MY_PN}-${PV}-1-x86_64.pkg.tar.xz"

LICENSE="Sublime"
SLOT="0"
KEYWORDS="~amd64"
# IUSE=""
BDEPEND=""
RDEPEND="gui-libs/gtk net-misc/curl"
DEPEND="${RDEPEND}"
RESTRICT="strip bindist mirror"

S="${WORKDIR}"

QA_PREBUILD="
  opt/sublime_merge/chrash_handler
  opt/sublime_merge/git-credential-sublime
  opt/sublime_merge/ssh-askpass-sublime
  opt/sublime_merge/sublime_merge
"
QA_DESKTOP_FILE="usr/share/applications/sublime_merge.desktop"

src_install() {
  for size in 16 32 48 128 256; do
    doicon --context apps --theme hicolor --size ${size} usr/share/icons/hicolor/${size}x${size}/apps/${MY_PN}.png
  done
  domenu usr/share/applications/sublime_merge.desktop
  dobin usr/bin/smerge

  insinto /opt/sublime_merge
  doins -r opt/sublime_merge/.
  for bin in crash_handler git-credential-sublime ssh-askpass-sublime sublime_merge; do
    fperms +x /opt/sublime_merge/${bin}
  done
}
