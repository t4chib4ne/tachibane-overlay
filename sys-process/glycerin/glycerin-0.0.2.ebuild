# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="glycerin is a simple utility for logging a single application."
HOMEPAGE="https://github.com/t4chib4ne/glycerin"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/t4chib4ne/glycerin.git"
else
	SRC_URI="https://github.com/t4chib4ne/glycerin/archive/refs/tags/v${PV}.tar.gz"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

DOCS=( README.md )
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	# removes the CFLAGS so make.conf configuration
	# can be applied.
	sed -i 's/^CFLAGS=.*//g' Makefile || die
}

src_install() {
	dobin glycerin

	einstalldocs
	use man && doman glycerin.8
}
