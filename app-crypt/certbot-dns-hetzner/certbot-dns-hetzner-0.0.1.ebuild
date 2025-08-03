# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )


inherit distutils-r1

DESCRIPTION="Certbot authentication plugin for dns-01 validation via Hetzner."
HOMEPAGE="https://github.com/t4chib4ne/certbot-dns-hetzner"
SRC_URI="https://github.com/t4chib4ne/certbot-dns-hetzner/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-crypt/certbot-4.0.0"
