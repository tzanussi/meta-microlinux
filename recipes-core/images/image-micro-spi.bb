DESCRIPTION = "Creates all the artifacts needed to burn to SPI flash."

require image-micro.bb

EXTRA_IMAGEDEPENDS += "grub"
