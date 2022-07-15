FROM almalinux:9
RUN dnf --enablerepo crb install -y \
        binutils gcc gnu-efi gnu-efi-devel make redhat-rpm-config rpm-build yum-utils \
        wget dos2unix elfutils-libelf-devel git openssl openssl-devel pesign
COPY shim-unsigned-x64.spec /root/rpmbuild/SPECS/
COPY ml9secureboot001.der /root/rpmbuild/SOURCES/
COPY sbat.ml.csv /root/rpmbuild/SOURCES/
COPY shim-15.6.tar.bz2 /root/rpmbuild/SOURCES/
COPY shim-find-debuginfo.sh /root/rpmbuild/SOURCES/
COPY shim.patches /root/rpmbuild/SOURCES/
RUN rpmbuild -ba /root/rpmbuild/SPECS/shim-unsigned-x64.spec --noclean --define 'dist .el9'
COPY shimx64.efi /
RUN rpm2cpio /root/rpmbuild/RPMS/x86_64/shim-unsigned-x64-*.x86_64.rpm | cpio -diu
RUN sha256sum /usr/share/shim/*/x64/shimx64.efi /shimx64.efi
RUN hexdump -Cv /usr/share/shim/*/x64/shimx64.efi > /builtx64.hex
RUN hexdump -Cv /shimx64.efi > /origx64.hex
RUN diff -u /origx64.hex /builtx64.hex
