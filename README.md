# Port CVE-2019-2215 (bad binder) to Huawei P20lite (Android 8.0.0)

## Description

This project is an exploit for CVE-2019-2215 on Huawei P20lite in version Android 8.0.0. Kernel is
in version 4.4.23.

This vulnerability is probably the most documented one (tutorials, real port on physical phone) on
this topic and I have a vulnerable phone so this is a good starting point for learning Android
kernel exploitation.

Warning: The exploit makes all SELinux types permissive so it might allow other apps to bypass
SELinux. 

## Install

Clone the repo first :

```bash
git clone https://github.com/willboka/CVE-2019-2215-HuaweiP20Lite.git
cd CVE-2019-2215-HuaweiP20Lite
```

Clone [setools-android](https://github.com/xmikos/setools-android.git) in the folder
CVE-2019-2215-HuaweiP20Lite and compile **libsepol (libsepol.a)**. Use the following command to do
that :

```bash
make libsepol
```

It is required to bypass SELinux.

Build the project using the command :

```bash
make # or do: NDK_PROJECT_PATH=. ndk-build NDK_APPLICATION_MK=./Application.mk
```

Binary is in folder **libs/arm64-v8a**.

Build and push in `/data/local/tmp` using :

```bash
make push
```

## Usage

Launch the binary **cve-2019-2215** from CLI (tested with Termux and ADB) :

```bash
/data/local/tmp/cve-2019-2215 # from adb
```

Reboot to reset SELinux policies.

## Demo

![Exploit demo - mp4](demo.mp4)

## Links

Links I used to learn about exploiting this vulnerability.

### Test on virtual devices

- [Project Zero bad binder explanation](https://googleprojectzero.blogspot.com/2019/11/bad-binder-android-in-wild-exploit.html):
  Explanation of the vulnerability plus how to make it a arbitrary read / write primitive in the
  PoC.
- [Android Kernel Exploitation](https://cloudfuzz.github.io/android-kernel-exploitation/):
  Explains more in depth the vulnerability and setup for the vulnerability and there are added-value
  on debugging (GDB scripts, use of sanitizer).
- [Tailoring CVE-2019-2215 to Achieve Root](https://hernan.de/blog/tailoring-cve-2019-2215-to-achieve-root/):
  Method about bypassing Linux Kernel security features.

### Dev on real device

- [s8_2019_2215_poc](https://github.com/chompie1337/s8_2019_2215_poc/tree/master): Real case of
  porting the exploit - I use the avc cache bypass from this one but unfortunately I could not use
  the same technique to get symbol entries as I experience kernel crashes when reading some kernel
  pages. Instead I guess Kaslr offset from the first Kaslr affected symbol in the leaked
  task_struct (fair_sched_class).
- [cve2019-2215-3.18](https://github.com/enceka/cve-2019-2215-3.18): This exploit is actually the
  closest as the offset of wait field in binder_struct is 0xa8 in this case (0x98 in his case).
