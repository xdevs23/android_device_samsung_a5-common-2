#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit from common
$(call inherit-product, device/samsung/msm8916-common/msm8916.mk)

#Inherit from vendor
$(call inherit-product-if-exists, vendor/samsung/a5-common/a5-common-vendor-blobs.mk)

LOCAL_PATH := device/samsung/a5-common

# Common overlay
DEVICE_PACKAGE_OVERLAYS += \
	$(LOCAL_PATH)/overlay \
	$(LOCAL_PATH)/overlay-lineage

# Telephony
PRODUCT_PACKAGES += \
    qti-telephony-common \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Touch issue workaround
PRODUCT_PACKAGES += \
    InputDisabler

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf

# Include package config fragments
include $(LOCAL_PATH)/product/*.mk

# append the updater uri to the product properties if set
ifneq ($(CM_UPDATER_OTA_URI),)
	PRODUCT_PROPERTY_OVERRIDES += $(CM_UPDATER_OTA_URI)
endif

# Inhert dalvik heap values from aosp
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)
