HaveClip for Android
====================

This is a beta version of HaveClip for Android. Most of the features are already
implemented, but there may be a few glitches. The UI is incomplete and sometimes
not pretty.

Home page: http://www.havefun.cz/projects/haveclip/

Build
-----

HaveClip for Android requires custom OpenSSL version, as it is not shipped
with Qt itself.

It is tested with the currently latest openssl-1.0.2a. Prior to building OpenSSL,
configure environment variables using
[Setenv-android.sh](https://wiki.openssl.org/images/7/70/Setenv-android.sh.

Edit this script and set some variables, e.g.:

    ANDROID_NDK_ROOT="/home/android/sdk/android-ndk-r10d"
    _ANDROID_EABI="x86-4.9"
    _ANDROID_ARCH=arch-x86
    _ANDROID_API="android-14"

The OpenSSL is then built by:

    $ . Setenv-android.sh
    $ ./config
    $ make depend
    $ make all

The path to the built OpenSSL libraries must be then set in
`haveclip-android.pro`. HaveClip can now be built and deployed using Qt Creator.

License
-------
HaveClip is released under the GNU/GPL.
