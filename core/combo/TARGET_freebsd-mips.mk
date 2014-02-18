#
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Configuration for FreeBSD on MIPS64.
# Included by combo/select.mk

CHERI_TARGET_TRIPLE := mips4-unknown-freebsd
TARGET_TOOLCHAIN_ROOT := prebuilts/gcc/$(HOST_PREBUILT_TAG)/mips64/mips64-unknown-freebsd
TARGET_TOOLS_PREFIX := $(TARGET_TOOLCHAIN_ROOT)/bin/$(CHERI_TARGET_TRIPLE)-

android_config_h := $(call select-android-config-h,freebsd-mips)

TARGET_mips_CFLAGS += -integrated-as
TARGET_GLOBAL_CPPFLAGS += -integrated-as
TARGET_GLOBAL_LDFLAGS += -Xlinker -melf64btsmip_fbsd -Xlinker -v

include $(BUILD_COMBOS)/$(combo_target)linux-mips.mk

TARGET_DEFAULT_SYSTEM_SHARED_LIBRARIES := 

TARGET_CRTBEGIN_SO_O :=
TARGET_CRTEND_SO_O := 
LOCAL_NO_CRT := true

define transform-o-to-shared-lib-inner
 $(hide) $(PRIVATE_CXX) \
     -Wl,-soname,$(notdir $@) \
     -Wl,--gc-sections \
     -Wl,-shared,-Bsymbolic \
     $(PRIVATE_TARGET_GLOBAL_LD_DIRS) \
     $(if $(filter true,$(PRIVATE_NO_CRT)),,$(PRIVATE_TARGET_CRTBEGIN_SO_O)) \
     $(PRIVATE_ALL_OBJECTS) \
     -Wl,--whole-archive \
     $(call normalize-target-libraries,$(PRIVATE_ALL_WHOLE_STATIC_LIBRARIES)) \
     -Wl,--no-whole-archive \
     $(if $(PRIVATE_GROUP_STATIC_LIBRARIES),-Wl$(comma)--start-group) \
     $(call normalize-target-libraries,$(PRIVATE_ALL_STATIC_LIBRARIES)) \
     $(if $(PRIVATE_GROUP_STATIC_LIBRARIES),-Wl$(comma)--end-group) \
     $(PRIVATE_TARGET_LIBGCC) \
     $(PRIVATE_TARGET_FDO_LIB) \
     $(call normalize-target-libraries,$(PRIVATE_ALL_SHARED_LIBRARIES)) \
     -o $@ \
     $(PRIVATE_TARGET_GLOBAL_LDFLAGS) \
     $(PRIVATE_LDFLAGS) \
     $(PRIVATE_TARGET_LIBGCC) \
     $(if $(filter true,$(PRIVATE_NO_CRT)),,$(PRIVATE_TARGET_CRTEND_SO_O))
 endef

