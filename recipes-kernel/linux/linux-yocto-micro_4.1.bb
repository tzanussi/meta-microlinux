require recipes-kernel/linux/linux-yocto.inc

# We need lzma (as CONFIG_KERNEL_LZMA=y)
DEPENDS += "xz-native"

KBRANCH_DEFAULT_galileo = "standard/micro/galileo"
#KBRANCH_DEFAULT_minnowmax-64 = "micro/minnowmax"
KBRANCH = "${KBRANCH_DEFAULT}"

LINUX_KERNEL_TYPE = "micro"
KCONFIG_MODE = "--allnoconfig"

#SRCREV_machine ?= "4e30e64c44df9e59bd13239951bb8d2b5b276e6f"
#SRCREV_meta ?= "45393dd54f5ad77d43014c407c2b3520da42f427"

SRC_URI = "git://git.yoctoproject.org/linux-yocto-4.1.git;name=machine,lto,tinification;branch=${KBRANCH},lto,tinification; \
           git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=yocto-4.1;destsuffix=${KMETA}"

LINUX_VERSION ?= "4.1.2"

PV = "${LINUX_VERSION}+git${SRCPV}"

KMETA = "kernel-meta"
KCONF_BSP_AUDIT_LEVEL = "2"

COMPATIBLE_MACHINE = "(galileo|minnowmax-64)"

# Functionality flags
KERNEL_FEATURES = ""

EXTRA_OEMAKE = "LD=${STAGING_BINDIR_NATIVE}/${HOST_SYS}/${TARGET_PREFIX}ld AR=${STAGING_BINDIR_NATIVE}/${HOST_SYS}/${TARGET_PREFIX}gcc-ar"
