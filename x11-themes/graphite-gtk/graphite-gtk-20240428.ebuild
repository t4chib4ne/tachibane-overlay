# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# eg. 20211225 -> 2021-12-25
MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}"
MY_PN="${PN^}"

DESCRIPTION="Graphite gtk theme"
HOMEPAGE="https://github.com/vinceliuice/Graphite-gtk-theme"
SRC_URI="https://github.com/vinceliuice/Graphite-gtk-theme/archive/refs/tags/${MY_PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-theme-${MY_PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~amr64 ~ppc64"

IUSE="gnome gtk2"

DEPEND="gtk2? ( x11-themes/gtk-engines-murrine )
		gnome? ( x11-themes/gnome-themes-standard )
		>=x11-libs/gtk+-3.20:3"
RDEPEND="${DEPEND}"
BDEPEND="
		app-shells/bash
		dev-lang/sassc"

src_install() {
	dodir /usr/share/themes
	./install.sh -d "${ED}/usr/share/themes" --theme all --tweaks rimless normal"
}
