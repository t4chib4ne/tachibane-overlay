# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 xdg-utils gnome2-utils

DESCRIPTION="A Lightweight Radio Player."
HOMEPAGE="https://gitlab.com/goodvibes/goodvibes"

# There are no releases on GitLab?
EGIT_REPO_URI="https://gitlab.com/goodvibes/goodvibes.git"
EGIT_COMMIT="v${PV}"

PATCHES=(
	"${FILESDIR}"/man.patch
)

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui hotkeys inhibitor notifications pulseaudio pipewire dbus hls"
REQUIRED_USE="
	hotkeys? ( gui )
	inhibitor? ( gui )
	notifications? ( gui )
	|| ( pulseaudio pipewire )"

MY_GST_VER='1.24'
MY_GST_SLOT='1.0'

DEPEND=">=dev-libs/glib-2.66:2
		>=net-libs/libsoup-3.0:3.0
		>=media-libs/gstreamer-${MY_GST_VER}:${MY_GST_SLOT}
		>=media-libs/gst-plugins-base-${MY_GST_VER}:${MY_GST_SLOT}
		gui? ( >=x11-libs/gtk+-3.16:3 )
		hotkeys? ( >=dev-libs/keybinder-3.0.0 )"
RDEPEND="${DEPEND}
		>=media-libs/gst-plugins-bad-${MY_GST_VER}:${MY_GST_SLOT}
		gui? ( gnome-base/dconf )
		hls? ( >=media-libs/gst-plugins-ugly-${MY_GST_VER}:${MY_GST_SLOT} )
		pulseaudio? ( media-libs/libpulse )
		pipewire? ( media-video/pipewire[gstreamer] )
		dbus? ( sys-apps/dbus )"
BDEPEND="dev-build/meson"


src_configure() {
	local emesonargs=(
		$(meson_use gui 'ui-enabled')
		$(meson_use hotkeys 'feat-hotkeys')
		$(meson_use inhibitor 'feat-inhibitor')
		$(meson_use notifications 'feat-notifications')
		$(meson_use dbus 'feat-dbus-server')
		-Dtests=false
	)

	meson_src_configure
}

pkg_postinst() {
	if use gui; then
		xdg_desktop_database_update
		xdg_icon_cache_update
		gnome2_schemas_update
	fi
}

pkg_postrm() {
	if use gui; then
		xdg_desktop_database_update
		xdg_icon_cache_update
		gnome2_schemas_update
	fi
}
