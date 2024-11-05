# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="ncurses"
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 linux-info systemd # optfeature

DESCRIPTION="Glances an Eye on your system. A top/htop alternative for GNU/Linux, BSD, Mac OS and Windows operating systems. "
HOMEPAGE="https://github.com/nicolargo/glances"
SRC_URI="https://github.com/nicolargo/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="web-server hddtemp docker zeroconf requests pygal netifaces pymdstat pysnmp systemd" # wifi"

RDEPEND="
  $(python_gen_cond_dep '
    dev-python/defusedxml[${PYTHON_USEDEP}]
    dev-python/orjson[${PYTHON_USEDEP}]
    dev-python/packaging[${PYTHON_USEDEP}]
    >=dev-python/psutil-5.4.3[${PYTHON_USEDEP}]
    web-server? (
      dev-python/fastapi[${PYTHON_USEDEP}]
      dev-python/uvicorn[${PYTHON_USEDEP}]
    )
    docker? ( dev-python/docker[${PYTHON_USEDEP}] )
    zeroconf? ( dev-python/zeroconf[${PYTHON_USEDEP}] )
    requests? ( dev-python/requests[${PYTHON_USEDEP}] )
    pygal? ( dev-python/pygal[${PYTHON_USEDEP}] )
    netifaces? ( dev-python/netifaces[${PYTHON_USEDEP}] )
    pymdstat? ( dev-python/pymdstat[${PYTHON_USEDEP}] )
    pysnmp? ( dev-python/pysnmp[${PYTHON_USEDEP}] )
  ')
  hddtemp? ( app-admin/hddtemp )
"
  # wifi? ( net-wireless/python-wifi )

# PYTHON_USEDEP omitted on purpose
BDEPEND="doc? ( dev-python/sphinx-rtd-theme )"

CONFIG_CHECK="~TASK_IO_ACCOUNTING ~TASK_DELAY_ACCT ~TASKSTATS"

distutils_enable_tests unittest
distutils_enable_sphinx docs --no-autodoc

pkg_setup() {
  linux-info_pkg_setup
  python-single-r1_pkg_setup
}

src_prepare() {
  distutils-r1_src_prepare
}

src_install() {
  if use systemd; then
    systemd_newunit "${FILESDIR}/glances.service" "${PN}.service"
    if use web-server; then
      systemd_newunit "${FILESDIR}/glances-web.service" "${PN}-web.service"
    fi
  fi
  # elog "WRONG FILES?"
  # elog "$(ls ${D}/usr/share/doc/glances)"
  distutils-r1_src_install
  # elog "$(ls ${D}/usr/share/doc/glances)"
  # default
  # elog "MOVING WRONG FILES"
  # mv "${D}"/usr/share/doc/glances/* "${D}/usr/share/${P}/"
  wrong_files=(AUTHORS CONTRIBUTING.md COPYING glances.conf NEWS.rst README.rst SECURITY.md)
  for file in ${wrong_files[@]}; do
    # elog "$(ls ${D}/usr/share/doc/glances)"
    # elog "$(ls ${D}/usr/share/doc/glances/${file})"
    # elog "Moving ${file} ..."
    mv "${D}/usr/share/doc/glances/${file}" "${D}/usr/share/doc/${P}/${file}"
  done
  unset wrong_files file
  rmdir "${D}/usr/share/doc/glances"
  # elog "Proper DIR:"
  # elog "$(ls ${D}/usr/share/doc/${P})"
  # elog "Wrong DIR:"
  # elog "$(ls ${D}/usr/share/doc/glances)"
}

src_postinst() {
  elog "RUNNING SRC_POSTINST"
  mv "${D}/usr/share/doc/glances/*" "${D}/usr/share/${P}/"
}

python_test() {
  "${EPYTHON}" unittest-core.py || die "tests failed with ${EPYTHON}"
}

# pkg_postinst() {
  # optfeature "Autodiscover mode" dev-python/zeroconf
  # optfeature "Cloud support" dev-python/requests
  # optfeature "SVG graph support" dev-python/pygal
  # optfeature "IP plugin" dev-python/netifaces
  # optfeature "RAID monitoring" dev-python/pymdstat
  # optfeature "RAID support" dev-python/pymdstat
  # optfeature "SNMP support" dev-python/pysnmp
  # optfeature "WIFI plugin" net-wireless/python-wifi
  # elog "As net-wireless/python-wifi is no longer in the official repos, and the PyPi package doesn't function under Python 3, the WiFi plugin is unavailable."
# }
