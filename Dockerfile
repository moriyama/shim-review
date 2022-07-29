FROM centos:centos8
RUN sed -i \
    -e 's/mirrorlist=/#mirrorlist=/g' \
    -e 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' \
    /etc/yum.repos.d/CentOS-Linux-*
RUN dnf --enablerepo powertools \
    install -y \
    binutils gcc gnu-efi gnu-efi-devel make redhat-rpm-config rpm-build \
    yum-utils wget dos2unix elfutils-libelf-devel git openssl \
    openssl-devel pesign
COPY shim-unsigned-x64.spec /root/rpmbuild/SPECS/
COPY shim-15.6.tar.bz2 /root/rpmbuild/SOURCES/
COPY mlsecureboot004.der /root/rpmbuild/SOURCES/
COPY sbat.ml.csv /root/rpmbuild/SOURCES/
COPY shim-find-debuginfo.sh /root/rpmbuild/SOURCES/
COPY dbx.esl /root/rpmbuild/SOURCES/
COPY shim.patches /root/rpmbuild/SOURCES/
RUN rpmbuild -ba /root/rpmbuild/SPECS/shim-unsigned-x64.spec --noclean --define 'dist .el8'
RUN rpm2cpio /root/rpmbuild/RPMS/x86_64/shim-unsigned-ia32-*.x86_64.rpm | cpio -diu
RUN rpm2cpio /root/rpmbuild/RPMS/x86_64/shim-unsigned-x64-*.x86_64.rpm | cpio -diu
COPY shimx64.efi shimia32.efi /
RUN sha256sum \
    /usr/share/shim/*/x64/shimx64.efi /shimx64.efi \
    /usr/share/shim/*/ia32/shimia32.efi /shimia32.efi
RUN hexdump -Cv /usr/share/shim/*/ia32/shimia32.efi > /builtia32.hex
RUN hexdump -Cv /shimia32.efi > /origia32.hex
RUN hexdump -Cv /usr/share/shim/*/x64/shimx64.efi > /builtx64.hex
RUN hexdump -Cv /shimx64.efi > /origx64.hex
RUN diff -u /origia32.hex /builtia32.hex
RUN diff -u /origx64.hex /builtx64.hex
