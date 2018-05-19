
apt update
apt install -y build-essential
apt install -y make

mkdir /gcc-cross
mkdir /gcc-cross/bin
cd /gcc-cross

# build binutils
wget -nv http://ftp.gnu.org/gnu/binutils/binutils-2.26.tar.bz2
tar xf binutils-2.26.tar.bz2
mkdir build_binutils
cd build_binutils
../binutils-2.26/configure --prefix=/gcc-cross/bin --target=i686-elf
make -j4
make install
cd ..
PATH=/gcc-cross/bin:$PATH

# download gcc and dependencies
wget -nv https://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz
wget -nv https://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.bz2
wget -nv https://ftp.gnu.org/gnu/mpfr/mpfr-4.0.1.tar.bz2
wget -nv https://ftp.gnu.org/gnu/mpc/mpc-1.1.0.tar.gz
tar xf gcc-7.3.0.tar.gz
tar xf gmp-6.1.2.tar.bz2
tar xf mpfr-4.0.1.tar.bz2
tar xf mpc-1.1.0.tar.gz
mv gmp-6.1.2 gcc-7.3.0/gmp
mv mpfr-4.0.1 gcc-7.3.0/mpfr
mv mpc-1.1.0 gcc-7.3.0/mpc

# build gcc with dependencies
mkdir gcc-build
cd gcc-build
../gcc-7.3.0/configure --prefix=/gcc-cross/bin --target=i686-elf --enable-languages=c --without-nls --without-headers
make -j4 all-gcc
make install-gcc
