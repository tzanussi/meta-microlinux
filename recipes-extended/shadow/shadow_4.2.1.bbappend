FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_class-target = " \
           file://single-user-tty.patch \
           "
