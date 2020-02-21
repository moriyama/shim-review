This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch

Note that we really only have experience with using grub2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
Cybertrust Japan Co.,Ltd.

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
MIRACLE LINUX V8 Asianux inside

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Our products and customers need secure boot.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: YOSHIFUJI Hideaki
- Position: Expert Engineer
- Email address: hideaki.yoshifuji@miraclelinux.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: [hideaki_yoshifuji_177ABBE2344FD295.pub](hideaki_yoshifuji_177ABBE2344FD295.pub)

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Haruki TSURUMOTO
- Position: Engineer
- Email address: haruki.tsurumoto@miraclelinux.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: [haruki_tsurumoto_D65234EEE8B6B283.pub](haruki_tsurumoto_D65234EEE8B6B283.pub)

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
 https://github.com/rhboot/shim/tree/15

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
 https://github.com/miraclelinux/shim-review

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
 Those patches are include from Upstream.
- 0001-Make-sure-that-MOK-variables-always-get-mirrored.patch
- 0002-mok-fix-the-mirroring-of-RT-variables.patch
- 0003-mok-consolidate-mirroring-code-in-a-helper-instead-o.patch
- 0004-Make-VLogError-behave-as-expected.patch
- 0005-MokListRT-Fatal.patch

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
You can check it in docker environment.
This environment can replay our mock build environment. This environment is close to RHEL 8.1.

Please check in the following way.

```
 # git clone https://github.com/miraclelinux/shim-review.git
 # cd shim-review/
 # git checkout MLV8/master
 # cat AXS8shimbuild_tgz_* > AXS8shimbuild.tar.gz
 # podman build .
``` 


-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
 https://github.com/miraclelinux/shim-review/build.log

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
```
$ sha256sum shim*.efi
902bd983896a33dd8b15c5b55a48f9f16ca6e400614ec473385613156fc29546  shimia32.efi
64a40e48a337b7198e7293492a527114b087e6730a21fab92f96c162438f4fef  shimx64.efi
```
