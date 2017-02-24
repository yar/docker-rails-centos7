FROM centos:7

# Development tools
RUN yum install -y git openssh gcc make curl which tar gzip bzip2 unzip zip

# Dependencies for compiling some gems native extension
# Rquired by mysql2, pg
RUN yum install -y mariadb-devel postgresql-libs postgresql-devel

# RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable && \
    echo -e "install: --no-document\nupdate: --no-document" > ~/.gemrc
# If not running with bash -l, rvm command is not available
RUN bash -lc 'rvm install 2.3.3 && rvm use 2.3.3 --default && gem update --system && gem install bundler --no-document'

# Enable EPEL
RUN yum install -y epel-release yum-utils && yum-config-manager --enable epel

# Node
RUN yum install -y nodejs

# Clear cache
RUN yum clean all
