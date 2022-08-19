FROM almalinux:9
RUN dnf --enablerepo crb install -y \
        binutils gcc gnu-efi gnu-efi-devel make redhat-rpm-config rpm-build yum-utils \
        wget dos2unix elfutils-libelf-devel git openssl openssl-devel pesign
RUN wget https://kojipkgs.fedoraproject.org//packages/shim-unsigned-x64/15.6/1/src/shim-unsigned-x64-15.6-1.src.rpm
RUN rpm -ivh shim-unsigned-x64-15.6-1.src.rpm
COPY shim-unsigned-x64.spec /root/rpmbuild/SPECS/
COPY ml9secureboot001.der /root/rpmbuild/SOURCES/
COPY sbat.ml.csv /root/rpmbuild/SOURCES/
RUN rpmbuild -bb /root/rpmbuild/SPECS/shim-unsigned-x64.spec
RUN rpm2cpio /root/rpmbuild/RPMS/x86_64/shim-unsigned-x64-*.x86_64.rpm | cpio -diu
COPY shimx64.efi /
RUN hexdump -Cv /usr/share/shim/*/x64/shimx64.efi > /built-x64.hex
RUN hexdump -Cv /shimx64.efi > /orig-x64.hex
RUN objdump -h /usr/share/shim/*/x64/shimx64.efi
RUN diff -u orig-x64.hex built-x64.hex
RUN pesign -h -P -i /usr/share/shim/*/x64/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/*/x64/shimx64.efi /shimx64.efi
