# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Go compiler for small places."
HOMEPAGE="https://tinygo.org/"
SRC_URI="https://github.com/tinygo-org/tinygo/releases/download/v${PV}/tinygo${PV}.linux-amd64.tar.gz"

LICENSE="
	Apache-2.0-with-LLVM-exceptions
	Apache-2.0
"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/go
	>=llvm-core/clang-19
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_compile() {
	return
}

src_install() {
	insinto /opt
	doins -r tinygo
	doenvd "${FILESDIR}/tinygo.env"
}

pkg_postinst() {
	ewarn 'For using TinyGo with microcontrollers you will have to install some'
	ewarn 'extra tools. Please refer to the TinyGo documentation for your specific'
	ewarn 'board.'
}
