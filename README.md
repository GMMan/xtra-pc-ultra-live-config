Xtra-PC Ultra Debian Live Configuration
=======================================

This is a Debian Live configuration for creating installation media for Xtra-PC
Ultra. This config is based on the source CD received in October 2022, and
enhanced to automatically configure additional differences between a base
install from this configuration and the actual product. The original source CD
can be found on [Internet Archive](https://archive.org/details/xtra-pc-ultra-source).

This branch removes most of the branding, and allow you to customize the
installation more, but retains the desktop configuration and the custom apps
(because I think they're neat). Note auto-login is not enabled due to
non-static user name.

Please note that this repo does not contain the FileRez package, nor the
Windows launcher. It should otherwise produce a functionally identical
installation to the version of the product built in June 2022.

File permissions
----------------
Please note files in `config/includes.chroot` should have permissions produced
using `umask 0022`, aside from the contents of `/etc/sudoers.d`, which should
have permission (not umask) `440`.

Build instructions
------------------
Please see build instructions on the [repo's wiki](https://github.com/GMMan/xtra-pc-ultra-live-config/wiki/Build-instructions).

Java programs source
--------------------
Source code was not provided for the Java programs. Since Xtra-PC Ultra is
licensed under the GNU General Public License v2, you should be able to request
it from Prairie IT, the original maker of Xtra-PC. Please go
[here](https://www.xtra-pc.com/pages/support-xtra-pc-ultra) and click on the
"View Source Code" button for correspondence details.
