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

TARGET_TOOLCHAIN_ROOT := prebuilts/gcc/$(HOST_PREBUILT_TAG)/mips64/mips64-unknown-freebsd
TARGET_TOOLS_PREFIX := $(TARGET_TOOLCHAIN_ROOT)/bin/mips64-unknown-freebsd-

android_config_h := $(call select-android-config-h,freebsd-mips)

include $(BUILD_COMBOS)/$(combo_target)linux-mips.mk
