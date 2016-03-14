FROM centos:7

# Development tools
RUN yum install -y git openssh gcc make curl which tar

# Dependencies for compiling some gems native extension
# Rquired by mysql2
RUN yum install -y mariadb-devel

# RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
# If not running with bash -l, rvm command is not available
RUN echo -e "install: --no-document\nupdate: --no-document" > /etc/gemrc
RUN bash -lc 'rvm install 2.3.0'
RUN bash -lc 'rvm use 2.3.0 --default'
RUN bash -lc 'gem install bundler --no-document'

# Node
RUN curl -sL https://rpm.nodesource.com/setup_5.x | bash -
RUN yum install -y nodejs

# Clear cache
RUN yum clean all
