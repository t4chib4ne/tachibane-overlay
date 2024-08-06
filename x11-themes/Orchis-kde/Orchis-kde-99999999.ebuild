# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# eg. 20211225 -> 2021-12-25
MY_PN="${PN^}"
MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="Orchis themes for kde plasma."
HOMEPAGE="https://github.com/vinceliuice/Orchis-kde"

if [[ "${PV}" == 99999999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/vinceliuice/Orchis-kde.git"
else
	SRC_URI="https://github.com/vinceliuice/Orchis-kde/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~ppc64"
	S="${WORKDIR}/${MY_PN}-${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="x11-themes/kvantum"
RDEPEND="${DEPEND}"
BDEPEND="app-shells/bash"

src_install() {
	dodir /usr/share/Kvantum

	cp -r Kvantum/* "${ED}/usr/share/Kvantum"
}
