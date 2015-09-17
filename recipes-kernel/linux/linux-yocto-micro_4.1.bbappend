FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

LINUX_VERSION_i586-nlp-32-intel-common = "4.1.2"
COMPATIBLE_MACHINE_i586-nlp-32-intel-common = "${MACHINE}"
KMACHINE_i586-nlp-32-intel-common = "intel-quark"
KBRANCH_i586-nlp-32-intel-common = "standard/base"
SRCREV_meta_i586-nlp-32-intel-common ?= "45393dd54f5ad77d43014c407c2b3520da42f427"
SRCREV_machine_i586-nlp-32-intel-common ?= "4e30e64c44df9e59bd13239951bb8d2b5b276e6f"
KERNEL_FEATURES_append_i586-nlp-32-intel-common = ""

SRC_URI = "git:///home/trz/yocto/microlinux-dozy/kernels/linux-yocto-micro-4.1.git;protocol=file;name=machine,lto,tinification,net-diet,staging,xip,tracing;branch=${KBRANCH},lto,tinification,net-diet,staging,xip,tracing; \
           git:///home/trz/yocto/microlinux-dozy/kernels/yocto-kernel-cache-micro.git;protocol=file;type=kmeta;name=meta;branch=yocto-4.1;destsuffix=${KMETA}"

SRCREV_machine_${MACHINE}="${AUTOREV}"
SRCREV_meta="${AUTOREV}"
SRCREV_lto="${AUTOREV}"
SRCREV_tinification="${AUTOREV}"
SRCREV_net-diet="${AUTOREV}"
SRCREV_staging="${AUTOREV}"
SRCREV_xip="${AUTOREV}"
SRCREV_tracing="${AUTOREV}"
LOCALCOUNT = "0"

COMPATIBLE_MACHINE = "(galileo|minnowmax-64)"

RDEPENDS_kernel-base=""

# Merge the lto branch.  We need to turn ftrace off when using lto.
KERNEL_FEATURES_LTO = "features/ftrace/ftrace-disable.scc \
                       features/lto/lto.scc \
		      "

# Merge the staging branch and disable the staging options.
KERNEL_FEATURES_TINIFICATION_STAGING = "features/tinification/staging.scc \
                                cfg/devmem-memdev-disable.scc \
                                cfg/devmem-nonessential-disable.scc \
                                cfg/devmem-random-disable.scc \
                                cfg/proc-min-enable.scc \
                               "

# Merge the tinification branch and disable the tinification options.
KERNEL_FEATURES_TINIFICATION = "features/tinification/tinification.scc \
                                cfg/perf-disable.scc \
                                cfg/x86-feature-names-disable.scc \
                                cfg/advise-syscalls-disable.scc \
                                cfg/write-to-rtc-disable.scc \
                                cfg/x86-model-table-disable.scc \
                                cfg/obsolete-syscalls-disable.scc \
                                cfg/user-io-disable.scc \
                                cfg/splice-disable.scc \
                                cfg/sysfs-syscall-disable.scc \
                                cfg/uselib-disable.scc \
                                ${KERNEL_FEATURES_TINIFICATION_STAGING} \
                               "

KERNEL_FEATURES_NET_DIET = "features/net-diet/net-diet.scc \
                            cfg/rhashtable-disable.scc \
                            cfg/ntp-disable.scc \
                            cfg/net/rtnetlink-disable.scc \
                            cfg/net/ethtool-disable.scc \
                            cfg/net/ip-ping-disable.scc \
                            cfg/net/tcp-metrics-disable.scc \
                            cfg/net/ip-offload-disable.scc \
                            cfg/net/packet-mmap-disable.scc \
                            cfg/net/tcp-fastopen-disable.scc \
                            features/crypto/crypto-disable.scc \
                           "

# Smallest 'normal' kernel i.e. can be used to scp new kernel to sd card
# and see dmesg, oops, etc.  Cuts past this affect *something* important.
KERNEL_FEATURES_SMALLEST_NORMAL = "${KERNEL_FEATURES_LTO} \
			${KERNEL_FEATURES_TINIFICATION} \
			${KERNEL_FEATURES_NET_DIET} \
			${KERNEL_FEATURES_TRACING} \
			${KERNEL_FEATURES_XIP} \
                        cfg/nohz-disable.scc \
                        cfg/misc-disable.scc \
                        features/crypto/crypto-disable.scc \
                        cfg/hrt-disable.scc \
                        cfg/proc-sysctl-disable.scc \
                        cfg/x86-verbose-boot-disable.scc \
                        ${@base_contains('DISTRO_FEATURES', 'tracing', '', 'cfg/slob.scc', d)} \
                        cfg/gpio-user-disable.scc \
                        cfg/net/packet-disable.scc \
                        cfg/net/ipv6-disable.scc \
                        cfg/pcie-disable.scc \
                        cfg/sysfs-disable.scc \
                        cfg/mtd-disable.scc \
                        cfg/kallsyms-enable.scc \
                        "

# Smallest useable kernel i.e. boots to usable shell, nothing more guaranteed
KERNEL_FEATURES_SMALLEST = "${KERNEL_FEATURES_SMALLEST_NORMAL} \
                           ${@base_contains('DISTRO_FEATURES', 'single-user', 'cfg/multiuser-disable.scc', '', d)} \
                           cfg/virt-kmem.scc \
                           cfg/proc-disable.scc \
                           cfg/proc-min-disable.scc \
                           cfg/acpi-disable.scc \
                           cfg/pty-disable.scc \
                           cfg/mmc-disable.scc \
                           cfg/block-disable.scc \
                           cfg/inet-disable.scc \
                           cfg/net-disable.scc \
                           cfg/bug-disable.scc \
                           cfg/kallsyms-disable.scc \
                           cfg/thermal-disable.scc \
                           cfg/printk-disable.scc \
                           cfg/hz-periodic.scc \
                           cfg/cpu-idle-disable.scc \
                           cfg/devmem-disable.scc \
                           cfg/msi-disable.scc \
                           cfg/x86-mce-disable.scc \
                           "

KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_SMALLEST_NORMAL} \
			cfg/pae-disable.scc \
                        "

#KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_SMALLEST} \
#			cfg/pae-disable.scc \
#                        "

KERNEL_FEATURES_append_minnowmax-64 += "${KERNEL_FEATURES_SMALLEST_NORMAL} \
                        "

KERNEL_FEATURES_TRACING_OPTIONS = "features/tracing/tracing.scc \
			   cfg/perf-enable.scc \
			   cfg/frame-pointers-enable.scc \
			   features/lto/lto-disable.scc \
			   features/ftrace/ftrace.scc \
			   cfg/kallsyms-enable.scc \
			   cfg/loglevel-debug.scc \
			   cfg/slub.scc \
			   cfg/slub-stats.scc \
                           cfg/proc-min-disable.scc \
                           cfg/proc-enable.scc \
			   cfg/proc-page-monitor-enable.scc \
                           "

KERNEL_FEATURES_TRACING = "${@base_contains('DISTRO_FEATURES', 'tracing', '${KERNEL_FEATURES_TRACING_OPTIONS}', '', d)}"

KERNEL_FEATURES_XIP_OPTIONS = "features/tinification/xip.scc \
                      features/qemu/blkdev-enable.scc \
                      "

KERNEL_FEATURES_XIP = "${@base_contains('DISTRO_FEATURES', 'xip', '${KERNEL_FEATURES_XIP_OPTIONS}', '', d)}"

# disabling lpf-filter-disable hangs kernel, which also means we can't disable
# bpf, since lpf filter selects it.  So bpf-disable remains untested as well.
# inet-raw-disable hangs kernel, no oops either
# fib-list was broken before and now even worse after hlist changes, need to
# fix compilation errors due to hlist and other changes - see fib_trie.c for
# how it should be since it was basicall copied from there and there seems
# to have been underlying changes to look at.
# - common-clk-enable - should be able to disable this but galileo selects it
KERNEL_FEATURES_BROKEN = "cfg/net/lpf-filter-disable.scc \
                          cfg/bpf-disable.scc \
                          cfg/net/inet-raw-disable.scc \
                          cfg/net/fib-list.scc \
                          cfg/common-clk-enable.scc \
                         "

# uncomment and replace these SRCREVs with the real commit ids once you've had
# the appropriate changes committed to the upstream linux-yocto repo
#SRCREV_machine_pn-linux-yocto-tiny_galileo ?= "840bb8c059418c4753415df56c9aff1c0d5354c8"
#SRCREV_meta_pn-linux-yocto-tiny_galileo ?= "4fd76cc4f33e0afd8f906b1e8f231b6d13b6c993"
#LINUX_VERSION = "4.1"
