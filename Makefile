.PHONY: default clean

default:
	@NDK_PROJECT_PATH=. ndk-build NDK_APPLICATION_MK=./Application.mk

push:
	@NDK_PROJECT_PATH=. ndk-build NDK_APPLICATION_MK=./Application.mk
	@adb push libs/arm64-v8a/cve-2019-2215 /data/local/tmp
	@adb shell chmod +x /data/local/tmp/cve-2019-2215

libsepol:
	@git clone https://github.com/xmikos/setools-android.git
	@NDK_PROJECT_PATH=setools-android ndk-build APP_ABI=arm64-v8a
	@cp setools-android/obj/local/arm64-v8a/libsepol.a .

clean:
	@adb shell rm /data/local/tmp/cve-2019-2215
