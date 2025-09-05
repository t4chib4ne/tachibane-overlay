# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
#
# TODO: docs

EAPI=8

RUST_MIN_VER="1.86.0"
export OPENSSL_NO_VENDOR=1

inherit cmake rust

DESCRIPTION="C API to expose the Wasmtime runtime"
HOMEPAGE="https://docs.wasmtime.dev/c-api/ https://github.com/bytecodealliance/wasmtime/blob/main/crates/c-api/README.md"
SRC_URI="https://github.com/bytecodealliance/wasmtime/releases/download/v${PV}/wasmtime-v${PV}-src.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="+shared fastest test"

DEPEND="
	app-arch/bzip2
	app-arch/zstd:=
	dev-libs/openssl
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/wasmtime-v${PV}-src"
CMAKE_USE_DIR="${S}/crates/c-api"
BUILD_DIR="${S}/target/c-api"

PATCHES=(
	# Tries adding a SONAME to the the .so
	"${FILESDIR}/${P}-fix-soname.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex shared)
		-DWASMTIME_FASTEST_RUNTIME=$(usex fastest)
		-DBUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_install() {
	# Removes their decleration of dst so we can fix it.
	sed -e '/set(dst.*/d' \
		"${CMAKE_USE_DIR}/cmake/install-headers.cmake" \
		> "${CMAKE_USE_DIR}/cmake/install-headers.cmake.tmp" \
		|| die 'could not remove dst declerations'

	# DESTINATION correctly uses the images so our dst fix
	# would break it.
	sed -i 's,DESTINATION "${dst}",DESTINATION "/usr/include",' \
		"${CMAKE_USE_DIR}/cmake/install-headers.cmake.tmp" \
		|| die 'could not fix DESTINATION'

	# Add our dst fix which lets it point to the include in
	# the image.
	echo "set(dst \"${PORTAGE_BUILDDIR}/image/usr/include\")" \
		| cat - "${CMAKE_USE_DIR}/cmake/install-headers.cmake.tmp" > "${CMAKE_USE_DIR}/cmake/install-headers.cmake" \
		|| die 'could not fix include path'

	cat "${CMAKE_USE_DIR}/cmake/install-headers.cmake"

	cmake_src_install
}
