# Configuration for Android on MIPS.
# Generating binaries for MIPS32/soft-float/little-endian

arch_variant_cflags := \
    -EL \
    -march=mips64 \
    -mtune=mips \
    -mips64 \
    -msoft-float

arch_variant_ldflags := \
    -EL
