LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := sepol
LOCAL_SRC_FILES := $(LOCAL_PATH)/libsepol.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/setools-android/jni/libsepol/include
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := cve-2019-2215
LOCAL_STATIC_LIBRARIES := sepol
LOCAL_C_INCLUDES := $(LOCAL_PATH)/exploit/include $(LOCAL_PATH)/setools-android/jni/libsepol/include
LOCAL_SRC_FILES := \
    exploit/cve_2019_2215.c \
    exploit/dac.c \
    exploit/kernel_rw.c \
    exploit/seccomp.c \
    exploit/selinux.c
include $(BUILD_EXECUTABLE)
