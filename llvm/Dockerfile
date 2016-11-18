FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install \
		gcc make file linux-devel libffi-devel \
		libz-devel cmake python27 && \
	wget -O /download/llvm-3.9.0.tar.xz \
		http://llvm.org/releases/3.9.0/llvm-3.9.0.src.tar.xz && \
	wget -O /download/cfe-3.9.0.src.tar.xz \
		http://llvm.org/releases/3.9.0/cfe-3.9.0.src.tar.xz && \
	wget -O /download/compiler-rt-3.9.0.src.tar.xz \
		http://llvm.org/releases/3.9.0/compiler-rt-3.9.0.src.tar.xz && \
	cd /build && \
	tar xf /download/llvm-3.9.0.tar.xz && \
	cd llvm-3.9.0.src && \
	tar xf /download/cfe-3.9.0.src.tar.xz -C tools && \
	tar xf /download/compiler-rt-3.9.0.src.tar.xz -C projects && \
	mv tools/cfe-3.9.0.src tools/clang && \
	mv projects/compiler-rt-3.9.0.src projects/compiler-rt

ADD patches /patches

RUN \
	cd /build/llvm-3.9.0.src && \
	patch -p0 < /patches/toolchain.patch

RUN \
	cd /build/llvm-3.9.0.src && \
	mkdir -v build && \
	cd build && \
	export HOST_GCC="$(gcc -print-search-dirs | grep install | sed 's/.*: //' | sed 's_/$__')" && \
	CC=gcc CXX=g++ cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DLLVM_LIBDIR_SUFFIX= \
		-DLLVM_ENABLE_FFI=ON \
		-DCMAKE_BUILD_TYPE=Release \
		-DLLVM_BUILD_LLVM_DYLIB=ON \
		-DLLVM_TARGETS_TO_BUILD="host" \
		-DLLVM_DEFAULT_TARGET_TRIPLE="x86_64-uc-linux-gnu" \
		-DLLVM_HOST_TRIPLE="x86_64-uc-linux-gnu" \
		-Wno-dev .. && \
	make -j4 && \
	pre-root /build/llvm-base-root && \
	make DESTDIR=/build/llvm-base-root install && \
	post-root /build/llvm-base-root

ADD control /control

RUN \
	cd /build/llvm-base-root && \
	rm -rf usr/share/man && \
	(strip --strip-unneeded usr/bin/* || true) && \
	(find -name "*.so*" -exec strip --strip-debug "{}" \; || true)

RUN \
	cd /build/llvm-base-root && \
	mkdir -p /build/libllvm-root/usr/lib && \
	cd usr/lib && \
	mv BugpointPasses*.so* LLVMHello*.so* libLLVM*.so* libLTO*.so* /build/libllvm-root/usr/lib/ && \
	make-deb \
		/build/libllvm-deb \
		/build/libllvm-root \
		/control/libllvm \
		/packages/libllvm_3.9.0-4_amd64.deb

RUN \
	cd /build/llvm-base-root && \
	mkdir -p /build/libclang-root/usr/lib && \
	cd usr/lib && \
	mv libclang*.so* /build/libclang-root/usr/lib/ && \
	make-deb \
		/build/libclang-deb \
		/build/libclang-root \
		/control/libclang \
		/packages/libclang_3.9.0-4_amd64.deb

RUN \
	cd /build/llvm-base-root && \
	mkdir -p /build/compiler-rt-root/usr/lib/clang/3.9.0/include && \
	cd usr/lib/clang/3.9.0 && \
	mv *.txt lib /build/compiler-rt-root/usr/lib/clang/3.9.0/ && \
	mv include/sanitizer /build/compiler-rt-root/usr/lib/clang/3.9.0/include/sanitizer && \
	make-deb \
		/build/compiler-rt-deb \
		/build/compiler-rt-root \
		/control/compiler-rt \
		/packages/compiler-rt_3.9.0-4_amd64.deb

RUN \
	cd /build/llvm-base-root && \
	mkdir -p /build/clang-analyzer-root/usr/bin && \
	cd usr/bin && \
	mv scan* /build/clang-analyzer-root/usr/bin/ && \
	cd .. && \
	mv libexec /build/clang-analyzer-root/usr/libexec && \
	mkdir -p /build/clang-analyzer-root/usr/share && \
	cd share && \
	mv scan* /build/clang-analyzer-root/usr/share/ && \
	make-deb \
		/build/clang-analyzer-deb \
		/build/clang-analyzer-root \
		/control/clang-analyzer \
		/packages/clang-analyzer_3.9.0-4_amd64.deb

RUN \
	cd /build/llvm-base-root && \
	mkdir -p /build/clang-root/usr/bin && \
	cd usr/bin && \
	mv *clang* c-index-test /build/clang-root/usr/bin/ && \
	mkdir -p /build/clang-root/usr/lib && \
	cd ../lib && \
	mv clang /build/clang-root/usr/lib/clang && \
	mv libclang*.a /build/clang-root/usr/lib/ && \
	mkdir -p /build/clang-root/usr/lib/cmake && \
	cd cmake && \
	mv clang /build/clang-root/usr/lib/cmake/clang && \
	cd ../../share && \
	mkdir -p /build/clang-root/usr/share && \
	mv clang /build/clang-root/usr/share/clang && \
	cd .. && \
	rmdir share && \
	mkdir -p /build/clang-root/usr/include && \
	cd include && \
	mv clang* /build/clang-root/usr/include/ && \
	make-deb \
		/build/clang-deb \
		/build/clang-root \
		/control/clang \
		/packages/clang_3.9.0-4_amd64.deb

RUN \
	cd /build/llvm-base-root && \
	mkdir -p /build/llvm-root/usr/bin && \
	cd usr/bin && \
	mv * /build/llvm-root/usr/bin/ && \
	cd .. && \
	rmdir bin && \
	mkdir -p /build/llvm-root/usr/lib && \
	cd lib && \
	mv libLLVM*.a /build/llvm-root/usr/lib/ && \
	mkdir -p /build/llvm-root/usr/lib/cmake && \
	cd cmake && \
	mv llvm /build/llvm-root/usr/lib/cmake/llvm && \
	cd .. && \
	rmdir cmake && \
	cd .. && \
	rmdir lib && \
	mkdir -p /build/llvm-root/usr/include && \
	cd include && \
	mv llvm* /build/llvm-root/usr/include/ && \
	cd .. && \
	rmdir include && \
	cd .. && \
	rmdir usr && \
	make-deb \
		/build/llvm-deb \
		/build/llvm-root \
		/control/llvm \
		/packages/llvm_3.9.0-4_amd64.deb

