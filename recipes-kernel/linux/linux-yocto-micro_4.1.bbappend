FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

LINUX_VERSION_i586-nlp-32-intel-common = "4.1.2"
COMPATIBLE_MACHINE_i586-nlp-32-intel-common = "${MACHINE}"
KMACHINE_i586-nlp-32-intel-common = "intel-quark"
KBRANCH_i586-nlp-32-intel-common = "standard/base"
SRCREV_meta_i586-nlp-32-intel-common ?= "45393dd54f5ad77d43014c407c2b3520da42f427"
SRCREV_machine_i586-nlp-32-intel-common ?= "4e30e64c44df9e59bd13239951bb8d2b5b276e6f"
KERNEL_FEATURES_append_i586-nlp-32-intel-common = ""

SRC_URI_galileo = "git:///home/trz/yocto/microlinux-dozy/kernels/linux-yocto-micro-4.1.git;protocol=file;name=machine;branch=${KBRANCH}; \
           git:///home/trz/yocto/microlinux-dozy/kernels/yocto-kernel-cache-micro.git;protocol=file;type=kmeta;name=meta;branch=yocto-4.1;destsuffix=${KMETA}"

SRCREV_machine_${MACHINE}="${AUTOREV}"
SRCREV_meta="${AUTOREV}"
LOCALCOUNT = "0"

COMPATIBLE_MACHINE = "(galileo|minnowmax-64)"

RDEPENDS_kernel-base=""

# uncomment and replace these SRCREVs with the real commit ids once you've had
# the appropriate changes committed to the upstream linux-yocto repo
#SRCREV_machine_pn-linux-yocto-tiny_galileo ?= "840bb8c059418c4753415df56c9aff1c0d5354c8"
#SRCREV_meta_pn-linux-yocto-tiny_galileo ?= "4fd76cc4f33e0afd8f906b1e8f231b6d13b6c993"
#LINUX_VERSION = "4.1"
