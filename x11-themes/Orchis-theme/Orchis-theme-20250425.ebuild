# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# eg. 20211225 -> 2021-12-25
MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"
MY_PN="${PN^}"

DESCRIPTION="Orchis is a Material Design theme for GNOME/GTK based desktop environments."
HOMEPAGE="https://github.com/vinceliuice/Orchis-theme"
SRC_URI="https://github.com/vinceliuice/Orchis-theme/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"

IUSE="gnome gtk2 primary"

DEPEND="gtk2? ( x11-themes/gtk-engines-murrine )
		gnome? ( x11-themes/gnome-themes-standard )
		>=x11-libs/gtk+-3.20:3"
RDEPEND="${DEPEND}"
BDEPEND="
		app-shells/bash
		dev-lang/sassc"

DOCS=(
	README.md
)

src_install() {
	einstalldocs

	dodir /usr/share/themes

	local primary_option=''

	if use primary; then
		primary_option=" --tweaks 'primary'"
	fi

	./install.sh -d "${ED}/usr/share/themes" --icon gentoo --theme 'all'"$primary_option" || die "Error running install.sh"
}
