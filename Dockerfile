FROM debian:jessie

env LLVM_CONFIG /usr/local/bin/llvm-config
env CLANG /usr/local/bin/clang
env BUILD_DEPS python3 cmake subversion

RUN mkdir /root/build && cd /root/build/ \
  && apt-get update \
  && apt-get install -y build-essential $BUILD_DEPS \
  && svn co -q https://llvm.org/svn/llvm-project/llvm/branches/release_37 llvm3.7 \
  && svn co -q https://llvm.org/svn/llvm-project/cfe/branches/release_37 llvm3.7/tools/clang \
  && mkdir /root/build/llvmbuild && cd /root/build/llvmbuild \
  && cd /root/build/llvmbuild && cmake -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_TARGETS_TO_BUILD="X86;ARM;NVPTX;AArch64;Mips;PowerPC" -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_BUILD_TYPE=Release ../llvm3.7 \
  && make -j8 && make install \
  && rm -rf /root/build \
  && apt-get purge -y $BUILD_DEPS && apt-get autoremove -y \
  && apt-get clean 
