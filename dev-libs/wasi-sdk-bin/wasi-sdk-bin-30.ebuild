# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="WASI-enabled WebAssembly C/C++ toolchain"
HOMEPAGE="https://github.com/WebAssembly/wasi-sdk"
SRC_URI="
	https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${PV}/wasi-sdk-${PV}.0-x86_64-linux.tar.gz
	https://raw.githubusercontent.com/WebAssembly/wasi-sdk/refs/tags/wasi-sdk-${PV}/README.md
"

LICENSE="
	Apache-2.0
	Apache-2.0-with-LLVM-exceptions
"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/wasi-sdk-${PV}.0-x86_64-linux"
MY_BASE_DIR='/opt/wasi-sdk'
QA_PRESTRIPPED="
	${MY_BASE_DIR}/bin/llvm-objcopy
	${MY_BASE_DIR}/bin/clang-21
	${MY_BASE_DIR}/bin/llvm-cxxfilt
	${MY_BASE_DIR}/bin/llvm-dwarfdump
	${MY_BASE_DIR}/bin/llvm-nm
	${MY_BASE_DIR}/bin/lld
	${MY_BASE_DIR}/bin/llvm-objdump
	${MY_BASE_DIR}/bin/llvm-strings
	${MY_BASE_DIR}/bin/clang-format
	${MY_BASE_DIR}/bin/llvm-config
	${MY_BASE_DIR}/bin/llvm-size
	${MY_BASE_DIR}/bin/llvm-dwp
	${MY_BASE_DIR}/bin/llvm-mc
	${MY_BASE_DIR}/bin/clang-tidy
	${MY_BASE_DIR}/bin/llvm-ar
	${MY_BASE_DIR}/bin/clang-apply-replacements
	${MY_BASE_DIR}/bin/llvm-symbolizer
"

src_compile() {
	return
}

src_install() {
	dodir "${MY_BASE_DIR}"
	insinto "${MY_BASE_DIR}"

	for f in $(find "${WORKDIR}/wasi-sdk-${PV}.0-x86_64-linux" -mindepth 1 -maxdepth 1); do
		doins -r ${f}
	done

	dodoc "${DISTDIR}/README.md"
}

pkg_postinst() {
	ewarn 'This ebuild does not put the WASI capable clang on your path.'
	ewarn 'You have to up the environment. The README contains more information.'
}
