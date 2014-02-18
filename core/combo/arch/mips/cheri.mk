# Configuration for Android on MIPS.
# Generating binaries for MIPS32/soft-float/little-endian

arch_variant_cflags := \
    -EB \
    -msoft-float

arch_variant_ldflags := \
    -EB
