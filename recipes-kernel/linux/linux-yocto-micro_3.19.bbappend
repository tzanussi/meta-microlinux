FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${PR}.1"

KBRANCH = "micro/galileo"

#SRC_URI = "git:///home/trz/yocto/galileo-next/kernels/linux-yocto-micro-3.19.git;protocol=file;bareclone=1;branch=${KBRANCH},${KMETA},net-diet,lto,tinification,staging;name=machine,meta,net-diet,lto,tinification,staging"

# We want MICRO features for a micro build
KERNEL_FEATURES_MICRO = "${KERNEL_FEATURES_LTO} \
                         ${KERNEL_FEATURES_NET_DIET} \
                         ${KERNEL_FEATURES_TINIFICATION} \
                         cfg/virt-kmem.scc \
                         cfg/acpi-disable.scc \
                         cfg/block-disable.scc \
                         cfg/pcie-disable.scc \
                         cfg/mmc-disable.scc \
                         cfg/mtd-disable.scc \
                         cfg/nohz-disable.scc \
                         cfg/misc-disable.scc \
                         cfg/bug-disable.scc \
                         cfg/printk-disable.scc \
                         cfg/proc-sysctl-disable.scc \
                         cfg/preempt-none.scc \
                         cfg/crypto-disable.scc \
                         cfg/hrt-disable.scc \
                         cfg/x86-verbose-boot-disable.scc \
                         cfg/slob.scc \
                         cfg/pty-enable.scc \
                         cfg/proc-min-enable.scc \
                         cfg/sysfs-disable.scc \
                         cfg/pae-disable.scc \
                        "

# Merge the lto branch.  We need to turn ftrace off when using lto.
KERNEL_FEATURES_LTO = "features/ftrace/ftrace-disable.scc \
                       features/lto/lto.scc \
		      "

# Merge the tinification branch and disable the tinification options.
# TODO: perf/user-io/splice/sysfs and uselib are my versions, use the
#       tinification versions instead.
KERNEL_FEATURES_TINIFICATION = "features/tinification/tinification.scc \
                                cfg/perf-disable.scc \
                                cfg/x86-feature-names-disable.scc \
                                cfg/advise-syscalls-disable.scc \
                                cfg/write-to-rtc-disable.scc \
                                cfg/user-io-disable.scc \
                                cfg/splice-disable.scc \
                                cfg/sysfs-syscall-disable.scc \
                                cfg/uselib-disable.scc \
                               "

# Merge the net-diet branch.  Disable non-default-disabled items.
# TODO: fix fib-list, currently we need to force trie and lose a few K.
KERNEL_FEATURES_NET_DIET = "features/net-diet/net-diet.scc \
                            cfg/net/ipv6-disable.scc \
                            cfg/net/packet-disable.scc \
                            cfg/net/fib-trie.scc \
                            cfg/rhashtable-disable.scc \
                           "

# These features are disabled by default in the net-diet branch.
# Add NET_ENABLE only if you need them enabled i.e. for an
# unminimized configuration.
KERNEL_FEATURES_NET_ENABLE = "cfg/net/ip-ping.scc \
                              cfg/net/tcp-metrics.scc \
                              cfg/net/ethtool.scc \
                              cfg/net/lpf-filter.scc \
                              cfg/net/rtnetlink.scc \
                              cfg/net/ip-offload.scc \
                              cfg/net/mib-stats.scc\
                              cfg/net/tcp-fastopen.scc \
                              cfg/net/inet-raw.scc \
                              cfg/net/packet-mmap.scc \
                              cfg/net/fib-trie.scc \
                             "

KERNEL_FEATURES_MICRO_TEST = "cfg/acpi-disable.scc \
                             "

# Keep TRACING out unless we're tracing
# Turn on perf if enabling ftrace (compile problems)
# Also, stacktrace and hash triggers require frame pointers
KERNEL_FEATURES_TRACING = "cfg/perf-enable.scc \
			   cfg/printk-enable.scc \
			   cfg/bug-enable.scc \
			   cfg/frame-pointers-enable.scc \
			   features/ftrace/ftrace.scc \
			   cfg/kallsyms-enable.scc \
			   cfg/loglevel-debug.scc \
			   cfg/slub.scc \
			   cfg/slub-stats.scc \
			   features/lto/lto-disable.scc \
			   cfg/x86-verbose-boot-enable.scc \
			   "

# These are things we use for lwip builds
KERNEL_FEATURES_LWIP = "cfg/inet-disable.scc"

# These are things we use for netless builds
KERNEL_FEATURES_NONET = "cfg/net-disable.scc"

# micro - this is the default thang
#KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_MICRO} \
#                                  "

# micro with no networking
#KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_MICRO} \
#                                   ${KERNEL_FEATURES_NONET} \
#                                  "

# micro with user space networking stack
#KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_MICRO} \
#                                   ${KERNEL_FEATURES_LWIP} \
#                                  "

# micro with tracing
#KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_MICRO} \
#                                   ${KERNEL_FEATURES_TRACING} \
#                                   "

# non-micro with tracing
#KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_TRACING} \
#                                   "

# Smallest 'normal' kernel i.e. can be used to scp new kernel to sd card
# and see dmesg, oops, etc.  Cuts past this affect *something* important.
KERNEL_FEATURES_SMALLEST_NORMAL = "${KERNEL_FEATURES_LTO} \
			cfg/pae-disable.scc \
			features/tinification/tinification.scc \
			cfg/perf-disable.scc \
			features/tinification/staging.scc \
			cfg/proc-min-enable.scc \
                        cfg/x86-feature-names-disable.scc \
                        cfg/advise-syscalls-disable.scc \
                        cfg/nohz-disable.scc \
                        cfg/misc-disable.scc \
                        cfg/proc-sysctl-disable.scc \
                        cfg/preempt-none.scc \
                        cfg/crypto-disable.scc \
                        cfg/hrt-disable.scc \
                        cfg/x86-verbose-boot-disable.scc \
                        cfg/user-io-disable.scc \
                        cfg/write-to-rtc-disable.scc \
                        cfg/x86-model-table-disable.scc \
                        cfg/obsolete-syscalls-disable.scc \
                        cfg/rhashtable-disable.scc \
                        cfg/ntp-disable.scc \
                        cfg/splice-disable.scc \
                        cfg/devmem-memdev-disable.scc \
                        cfg/devmem-nonessential-disable.scc \
                        cfg/devmem-random-disable.scc \
                        cfg/slob.scc \
                        cfg/uselib-disable.scc \
                        cfg/sysfs-syscall-disable.scc \
                        cfg/gpio-user-disable.scc \
                        cfg/net/ipv6-disable.scc \
                        cfg/net/packet-disable.scc \
                        cfg/sysfs-disable.scc \
                        cfg/pcie-disable.scc \
                        "

KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_SMALLEST_NORMAL} \
                        "

# valuable features but broken and need fixing:
# - multiuser - saves about 15k but needs userspace fixes, can't log in
# - common-clk-enable - should be able to disable this but galileo selects it
KERNEL_FEATURES_BROKEN = "${KERNEL_FEATURES_LTO} \
                          cfg/multiuser-disable.scc \
                          cfg/common-clk-enable.scc \
                          "

# Smallest useable kernel i.e. boots to usable shell, nothing more guaranteed
KERNEL_FEATURES_SMALLEST = "${KERNEL_FEATURES_SMALLEST_NORMAL} \
                           "

#KERNEL_FEATURES_append_galileo += "${KERNEL_FEATURES_SMALLEST} \
#                        "

SRCREV_machine_${MACHINE}="${AUTOREV}"
SRCREV_meta="${AUTOREV}"
SRCREV_net-diet="${AUTOREV}"
SRCREV_lto="${AUTOREV}"
SRCREV_tinification="${AUTOREV}"
SRCREV_staging="${AUTOREV}"
LOCALCOUNT = "0"

COMPATIBLE_MACHINE_ = "galileo"

RDEPENDS_kernel-base=""

# uncomment and replace these SRCREVs with the real commit ids once you've had
# the appropriate changes committed to the upstream linux-yocto repo
#SRCREV_machine_pn-linux-yocto-tiny_galileo ?= "840bb8c059418c4753415df56c9aff1c0d5354c8"
#SRCREV_meta_pn-linux-yocto-tiny_galileo ?= "4fd76cc4f33e0afd8f906b1e8f231b6d13b6c993"
#LINUX_VERSION = "3.19.1"
