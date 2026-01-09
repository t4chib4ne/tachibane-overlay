# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Tiny but flexible init system and process supervisor."
HOMEPAGE="https://github.com/leahneukirchen/nitro"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/leahneukirchen/nitro.git"
else
	SRC_URI="https://github.com/leahneukirchen/nitro/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="0BSD"
SLOT="0"
IUSE="+cli +man tiny"

DOCS=( README.md NEWS.md )
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	# removes the CFLAGS so make.conf configuration
	# can be applied.
	sed -i 's/^CFLAGS=.*//g' Makefile || die
}

src_compile() {
	if use tiny; then
		emake tiny || die
	else
		emake nitro || die
	fi

	if use cli; then
		emake nitroctl || die
	fi
}

src_install() {
	dobin nitro
	use cli && dobin nitroctl

	einstalldocs
	# We don't install halt.8 because we don't
	# use nitro as pid 1.
	if use man; then
		doman nitro.8
		use cli && doman nitroctl.1
	fi
}

pkg_postinst() {
	ewarn "This ebuild does not provide any scripts for using nitro as pid 1."
	ewarn "Please read the README otherwise you are on your own."
}
