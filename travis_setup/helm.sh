#!/usr/bin/env bash

set -x

#check_or_build_nsenter derived from https://github.com/bitnami/kubernetes-travis/blob/master/scripts/cluster-up-minikube.sh (Apache 2.0 License)
check_or_build_nsenter() {
    which nsenter >/dev/null && return 0
    echo "INFO: Building 'nsenter' ..."
cat <<-EOF | docker run -i --rm -v "$(pwd):/build" ubuntu:14.04 >& nsenter.build.log
        apt-get update
        apt-get install -qy git bison build-essential autopoint libtool automake autoconf gettext pkg-config
        git clone --depth 1 git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git /tmp/util-linux
        cd /tmp/util-linux
        ./autogen.sh
        ./configure --without-python --disable-all-programs --enable-nsenter
        make nsenter
        cp -pfv nsenter /build
EOF
    if [ ! -f ./nsenter ]; then
        echo "ERROR: nsenter build failed, log:"
        cat nsenter.build.log
        return 1
    fi
    echo "INFO: nsenter build OK, installing ..."
    sudo install -v nsenter /usr/local/bin
}

# helm on minikube's vm-driver=none requires nsenter
check_or_build_nsenter

curl -Lo helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz && tar xf helm.tar.gz && chmod +x linux-amd64/helm && sudo mv linux-amd64/helm /usr/local/bin/


sudo chmod +x /usr/local/bin/helm
