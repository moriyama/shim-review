Make sure you have provided the following information:

 - [x] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
  - https://github.com/miraclelinux/shim-review/tree/MLV8/master
 - [x] completed README.md file with the necessary information
  - https://github.com/miraclelinux/shim-review/blob/MLV8/master/README.md
 - [x] shim.efi to be signed
  - https://github.com/miraclelinux/shim-review/blob/MLV8/master/shimx64.efi
  - https://github.com/miraclelinux/shim-review/blob/MLV8/master/shimia32.efi
 - [x] public portion of your certificate embedded in shim (the file passed to VENDOR_CERT_FILE)
  - https://github.com/miraclelinux/shim-review/blob/MLV8/master/asianuxsecureboot001.der
 - [x] any extra patches to shim via your own git tree or as files
  - Please find 5 .patch files in that tree.
 - [x] any extra patches to grub via your own git tree or as files
  - None
 - [x] build logs
  - https://github.com/miraclelinux/shim-review/blob/MLV8/master/build.log


###### What organization or people are asking to have this signed:
`Cybertrust Japan Co.,Ltd. `

###### What product or service is this for:
`MIRACLE LINUX V8 Asianux inside`

###### What is the origin and full version number of your shim?
Origin: `shim-15`
Full version: `shim-15-2.0.1`

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
`Our products and customers need secure boot.`

###### How do you manage and protect the keys used in your SHIM?
`There are in our local build system.`

###### Do you use EV certificates as embedded certificates in the SHIM?
`No.`

###### What is the origin and full version number of your bootloader (GRUB or other)?
`grub2-2.02-78.el8 from RHEL 8.1`

###### If your SHIM launches any other components, please provide further details on what is launched
`fwupd, fwupdate.`

###### How do the launched components prevent execution of unauthenticated code?
`No other code will launch.`

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
`No.`

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
`Kernel 4.18 rebuilt from RHEL kernel includes Secure Boot patches.`

###### What changes were made since your SHIM was last signed?
`It is my first sign review.`

###### What is the hash of your final SHIM binary?
```
$ sha256sum shim*.efi
902bd983896a33dd8b15c5b55a48f9f16ca6e400614ec473385613156fc29546  shimia32.efi
64a40e48a337b7198e7293492a527114b087e6730a21fab92f96c162438f4fef  shimx64.efi
```
