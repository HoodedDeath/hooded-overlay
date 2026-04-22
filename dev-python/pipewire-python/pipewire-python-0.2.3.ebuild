EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python controller, player and recorder via pipewire's commands"
HOMEPAGE="
	https://github.com/pablodz/pipewire_python
	https://pypi.org/project/pipewire_python/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-video/pipewire"

distutils_enable_tests unittest
