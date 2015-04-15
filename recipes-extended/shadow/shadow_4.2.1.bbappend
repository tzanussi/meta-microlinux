FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_class-target = " \
           ${@base_contains('DISTRO_FEATURES', 'single-user', 'file://single-user-tty.patch', '', d)} \
           "
