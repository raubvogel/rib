FROM rockylinux:8-minimal AS devstuff

################## BEGIN INSTALLATION ######################

RUN microdnf update -y && \
    microdnf install -y epel-release
RUN microdnf install -y \
    rpm-build mock createrepo git-core \
    autoconf \
    automake \
    binutils \
    bison \
    flex \
    gcc \
    gcc-c++ \
    gdb \
    glibc-devel \
    libtool \
    make \
    pkgconf \
    pkgconf-m4 \
    pkgconf-pkg-config \
    redhat-rpm-config \
    rpm-build \
    rpm-sign \
    strace \
    asciidoc \
     byacc \
    ctags \
    diffstat \
    elfutils-libelf-devel \
    git \
    intltool \
    jna \
    ltrace \
    patchutils \
    perl-Fedora-VSP \
    perl-Sys-Syslog \
    perl-generators \
    pesign \
    source-highlight \
    systemtap \
    valgrind \
    valgrind-devel \
    cmake \
    expect \
    rpmdevtools \
    rpmlint \
    golang \
    mock-core-configs \
    createrepo \
    nginx

##################### INSTALLATION END #####################

FROM devstuff AS devenv

ENV DEVUSER iamdeving
ENV DEVID 1995
ENV EXTGID 1999
ENV GOPATH /home/$DEVUSER/devtools-main

# Create $DEVUSER
RUN useradd -m --shell /bin/bash -u $DEVID $DEVUSER

# Switch to $DEVUSER
USER $DEVUSER
ENV WD /home/${DEVUSER}
WORKDIR ${WD}

RUN curl -OJL https://github.com/rocky-linux/devtools/archive/refs/heads/main.zip
RUN curl -OJL https://github.com/rocky-linux/srpmproc/archive/refs/heads/main.zip
RUN unzip devtools-main.zip && \
    unzip srpmproc-main.zip && \
    cd srpmproc-main && \
   CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ./cmd/srpmproc
USER root
RUN cd devtools-main && \
    make scriptinstall
RUN cp srpmproc-main/srpmproc /usr/bin/srpmproc && \
    rm -rf srpmproc-main* devtools-main*
USER $DEVUSER

# Start service

