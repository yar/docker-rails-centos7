FROM centos:7

ENV LANG=en_US.UTF-8 \
    RUBY_MAJOR=2.4 \
    RUBY_VERSION=2.4.1 \
    RUBY_DOWNLOAD_SHA256=a330e10d5cb5e53b3a0078326c5731888bb55e32c4abfeb27d9e7f8e5d000250 \
    RUBY_DOWNLOAD_MIRROR=https://cache.ruby-lang.org/pub/ruby/

# Development tools for compiling Ruby and native gem extension
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
# https://github.com/rvm/rvm/blob/master/scripts/functions/requirements/centos
RUN yum update -y && \
    yum install -y autoconf gcc gcc-c++ make automake patch && \
    yum install -y git openssh curl which tar gzip bzip2 unzip zip && \
    yum install -y openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel && \
    yum install -y mariadb-devel postgresql-libs postgresql-devel && \
    yum install -y epel-release yum-utils && \
    yum-config-manager --enable epel && \
    yum install -y nodejs && \
    curl -o /etc/yum.repos.d/yarn.repo https://dl.yarnpkg.com/rpm/yarn.repo && \
    yum install -y yarn && \
    yum clean all

# https://github.com/docker-library/ruby/blob/master/2.3/Dockerfile
RUN set -ex && \
    mkdir -p /usr/local/etc && \
    echo -e "install: --no-document\nupdate: --no-document" > /usr/local/etc/gemrc && \
    mkdir /build && cd /build && \
    curl -o ruby.tar.gz "$RUBY_DOWNLOAD_MIRROR/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" && \
    echo "$RUBY_DOWNLOAD_SHA256 ruby.tar.gz" | sha256sum -c - && \
    mkdir ruby && tar -xzf ruby.tar.gz -C ruby --strip-components=1 && \
    cd ruby && \
    ./configure --disable-install-doc --enable-shared && \
    make -j"$(nproc)" && \
    make install && \
    cd / && rm -rf /build && \
    gem update --system && gem install bundler && \
    rm -rf "$(gem env home)"/cache/*
