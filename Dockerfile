FROM debian:jessie

ENV LLVM_VERSION 3.8
ENV LLVM_CONFIG /usr/lib/llvm-${LLVM_VERSION}/bin/llvm-config
ENV CLANG /usr/bin/clang-${LLVM_VERSION}

RUN apt-get update \
  && apt-get install -y wget \
  && wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add - \
  && echo deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie-${LLVM_VERSION} main >> /etc/apt/sources.list \
  && echo deb-src http://apt.llvm.org/jessie/ llvm-toolchain-jessie-${LLVM_VERSION} main >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y llvm-${LLVM_VERSION}-dev clang-${LLVM_VERSION} \
  && apt-get clean 
