LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	bluetooth.c \
	sdp.c \
	hci.c \
	uuid.c \

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/bluetooth \

LOCAL_SHARED_LIBRARIES := \
	libcutils \
	liblog \

LOCAL_MODULE:=libbluetooth

LOCAL_CFLAGS+=-O3

ifeq ($(HAVE_CUSTOM_BRCM_BTLA),true)
LOCAL_CFLAGS += -DBT_ALT_STACK
endif

include $(BUILD_SHARED_LIBRARY)
ifeq ($(COS_BUILD), true)
include $(BUILD_BSP_TO_PDK_LIB)
endif
