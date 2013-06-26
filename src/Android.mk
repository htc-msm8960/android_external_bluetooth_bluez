LOCAL_PATH:= $(call my-dir)

ifeq ($(HAVE_CUSTOM_BRCM_BTLA),true)
# Relative path from current dir to vendor brcm
ifneq ($(COS_BUILD), true)
BRCM_BT_SRC_ROOT_PATH := ../../../../vendor/broadcom/bt
else
BRCM_BT_SRC_ROOT_PATH := ../../../../../vendor/broadcom/bt
endif
ifeq ($(SUPER_LINE),true)
BRCM_BT_SRC_ROOT_PATH := ../$(BRCM_BT_SRC_ROOT_PATH)
endif

# Relative path from <mydroid> to brcm base
BRCM_BT_INC_ROOT_PATH := $(LOCAL_PATH)/$(BRCM_BT_SRC_ROOT_PATH)
endif

#
# libbluetoothd
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	android_bluez.c \
	adapter.c \
	agent.c \
	dbus-common.c \
	device.c \
	eir.c \
	error.c \
	event.c \
	glib-helper.c \
	log.c \
	main.c \
	manager.c \
	oob.c \
	oui.c \
	plugin.c \
	rfkill.c \
	sdpd-request.c \
	sdpd-service.c \
	sdpd-server.c \
	sdpd-database.c \
	sdp-xml.c \
	storage.c \
	textfile.c \
	attrib-server.c \
	../attrib/att.c \
	../attrib/client.c \
	../attrib/gatt.c \
	../attrib/gattrib.c \
	../attrib/utils.c \

LOCAL_CFLAGS:= \
	-DVERSION=\"4.93\" \
	-DSTORAGEDIR=\"/data/misc/bluetoothd\" \
	-DCONFIGDIR=\"/etc/bluetooth\" \
	-DSERVICEDIR=\"/system/bin\" \
	-DPLUGINDIR=\"/system/lib/bluez-plugin\" \
	-DANDROID_SET_AID_AND_CAP \
	-DANDROID_EXPAND_NAME \
	-DOUIFILE=\"/data/misc/bluetoothd/ouifile\" \

ifeq ($(BOARD_HAVE_BLUETOOTH_BCM),true)
LOCAL_CFLAGS += \
	-DBOARD_HAVE_BLUETOOTH_BCM
endif

ifeq ($(HAVE_CUSTOM_BRCM_BTLA),true)
LOCAL_CFLAGS += -DBT_ALT_STACK
endif

ifeq ($(BOARD_HAVE_BLUETOOTH_BLE),true)
LOCAL_CFLAGS += -DBLE_ENABLED
endif

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/../attrib \
	$(LOCAL_PATH)/../btio \
	$(LOCAL_PATH)/../lib \
	$(LOCAL_PATH)/../gdbus \
	$(LOCAL_PATH)/../plugins \
	$(call include-path-for, glib) \
	$(call include-path-for, glib)/glib \
	$(call include-path-for, dbus)

ifeq ($(HAVE_CUSTOM_BRCM_BTLA),true)
LOCAL_SRC_FILES += \
	$(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/dtunc_bz4/dtun_clnt.c \
	$(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/dtunc_bz4/dtun_device.c \
	$(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/dtunc_bz4/dtun_obex.c \
	$(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/dtunc_bz4/dtun_hcid.c \
	$(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/dtunc_bz4/dtun_pan.c \
	$(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/dtunc_bz4/dtun_input.c \
	$(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/dtunc_bz4/dtun_sdp.c \
        $(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/dtunc_bz4/dtun_hl.c

LOCAL_C_INCLUDES += \
	$(BRCM_BT_INC_ROOT_PATH)/adaptation/dtun/include \
	$(BRCM_BT_INC_ROOT_PATH)/adaptation/include \
	$(BRCM_BT_INC_ROOT_PATH)/include \
	$(BRCM_BT_INC_ROOT_PATH)/adaptation/dtun/dtunc_bz4 \
	$(BRCM_BT_INC_ROOT_PATH)/adaptation/include \
	$(BRCM_BT_SRC_ROOT_PATH)/include \
	$(BRCM_BT_SRC_ROOT_PATH)/adaptation/dtun/include

endif

LOCAL_SHARED_LIBRARIES := \
	libdl \
	libbluetooth \
	libbtio \
	libdbus \
	libcutils \
	libglib \

LOCAL_STATIC_LIBRARIES := \
	libbuiltinplugin \
	libgdbus_static

LOCAL_MODULE:=libbluetoothd

include $(BUILD_SHARED_LIBRARY)
ifeq ($(COS_BUILD), true)
include $(BUILD_BSP_TO_PDK_LIB)
endif

#
# bluetoothd
#

include $(CLEAR_VARS)

LOCAL_SHARED_LIBRARIES := \
	libbluetoothd

LOCAL_MODULE:=bluetoothd

include $(BUILD_EXECUTABLE)
ifeq ($(COS_BUILD), true)
include $(BUILD_BSP_TO_PDK_LIB)
endif
