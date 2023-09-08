FROM rockylinux:8-minimal AS devstuff

################## BEGIN INSTALLATION ######################

RUN microdnf update -y && \
    microdnf install -y epel-release
RUN microdnf install -y \
    git \
    curl \
    mock 

##################### INSTALLATION END #####################

FROM devstuff AS devenv

ENV DEVUSER iamdeving
ENV DEVID 1995
ENV EXTGID 1999
ENV GOPATH /home/$DEVUSER/devtools-main

RUN microdnf install -y \
    vim

# Create $DEVUSER
RUN useradd -m --shell /bin/bash -g mock -u $DEVID $DEVUSER

# If you need to be root inside container, comment the next lines out
USER ${DEVUSER}
WORKDIR /home/${DEVUSER}

# Put the entrypoint script somewhere we can find
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
