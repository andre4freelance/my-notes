sudo apt-get update
sudo apt-get install git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build
wget https://download.qemu.org/qemu-4.2.0.tar.xz
tar xf qemu-4.2.0.tar.xz
cd qemu-4.2.0
./configure --prefix=/opt/qemu-4.2.0
make -j$(nproc)
sudo make install
echo 'export PATH=/opt/qemu-4.2.0/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
/opt/qemu-4.2.0/bin/qemu-system-x86_64 --version
