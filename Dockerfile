FROM ubuntu:15.10
MAINTAINER Masato Yamamoto <jajkeqos+docker@gmail.com>

ENV SWIFT_BRANCH development
ENV SWIFT_VERSION DEVELOPMENT-SNAPSHOT-2016-04-25-a
ENV SWIFT_PLATFORM ubuntu15.10

# Install related packages
RUN apt-get update && \
    apt-get install -y build-essential wget clang libedit-dev python2.7 python2.7-dev libicu55 rsync libxml2 git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Swift keys
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

# Install Swift Ubuntu 15.10 Snapshot
RUN SWIFT_ARCHIVE_NAME=swift-$SWIFT_VERSION-$SWIFT_PLATFORM && \
    SWIFT_URL='https://swift.org/builds/development/ubuntu1510/swift-DEVELOPMENT-SNAPSHOT-2016-03-24-a/swift-DEVELOPMENT-SNAPSHOT-2016-03-24-a-ubuntu15.10.tar.gz' && \
    wget $SWIFT_URL && \
    tar -xvzf swift-DEVELOPMENT-SNAPSHOT-2016-03-24-a-ubuntu15.10.tar.gz --directory / --strip-components=1 && \
    rm -rf swift-DEVELOPMENT-SNAPSHOT-2016-03-24-a-ubuntu15.10* /tmp/* /var/tmp/*

# Set Swift Path
ENV PATH /usr/bin:$PATH

# Print Installed Swift Version
RUN swift --version
