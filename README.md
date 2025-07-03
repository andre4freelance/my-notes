# My notes

This note summarizes some coamands that I often use but also often forget so I just note it here.

## 1. Instalasi QEMU 4.2.0

Ikuti langkah-langkah di bawah ini untuk menginstal QEMU versi 4.2.0 dari sumbernya:

1. Update repository and install depedencies :
   ```bash
   sudo apt-get update [cite: 2]
   sudo apt-get install libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build [cite: 2]
Download and Extract QEMU:

    ``bash
    wget [https://download.qemu.org/qemu-4.2.0.tar.xz](https://download.qemu.org/qemu-4.2.0.tar.xz) [cite: 2]
    tar xf qemu-4.2.0.tar.xz [cite: 2]
    cd qemu-4.2.0 [cite: 2]
Konfig, compile, and install QEMU:

    ``bash
    ./configure --prefix=/opt/qemu-4.2.0 [cite: 2]
    make -j$(nproc) [cite: 2]
    sudo make install [cite: 2]
Tambahkan direktori binari QEMU ke PATH Anda dan verifikasi instalasi:

Bash

echo 'export PATH=/opt/qemu-4.2.0/bin:$PATH' >> ~/.bashrc [cite: 2]
source ~/.bashrc [cite: 2]
/opt/qemu-4.2.0/bin/qemu-system-x86_64 --version [cite: 2]
2. Manajemen Mesin Virtual QEMU
Membuat dan Mem-boot Gambar Disk VM Baru
Buat berkas gambar QCOW2 baru untuk VM Anda:

Bash

qemu-img create -f qcow mikrotik.img 256M [cite: 4]
Boot gambar VM dengan berkas instalasi ISO (misalnya, Mikrotik.iso):

Bash

qemu-system-x86_64 mikrotik.img -cdrom mikrotik.iso -boot d [cite: 4]
Buka gambar VM setelah instalasi:

Bash

qemu-system-x86_64 mikrotik.img -boot c [cite: 4]
3. Membuat Pengguna Baru dengan Akses sudo
Untuk Sistem Debian/Ubuntu
Bash

sudo useradd -m -s /bin/bash username 
sudo passwd username 
sudo usermod -aG sudo username 
Untuk Sistem RHEL/CentOS/Rocky Linux
Bash

sudo useradd -m -s /bin/bash username 
sudo passwd username 
sudo usermod -aG wheel username 

Catatan: Ada perintah duplikat sudo usermod -aG sudo me di sumber RHEL yang tampaknya merupakan kesalahan ketik atau perintah yang tidak lengkap dan tidak digunakan dalam ringkasan ini. 

4. Pengaturan GitHub
Hasilkan kunci SSH baru:

Bash

ssh-keygen -t rsa -b 4096 [cite: 5]
Uji koneksi SSH Anda ke GitHub:

Bash

ssh -T git@github.com [cite: 5]
Konfigurasi informasi pengguna Git global Anda:

Bash

git config --global user.email "user@mail.com" [cite: 5]
git config --global user.name "username" [cite: 5]
5. Mengubah Port SSH di Rocky Linux
Ubah port SSH di berkas konfigurasi sshd_config:

Bash

# Edit /etc/ssh/sshd_config dan ubah baris 'Port' menjadi port yang diinginkan (misalnya, 2022) [cite: 3]
Tambahkan port baru ke firewalld:

Bash

sudo firewall-cmd --permanent --add-port=2022/tcp [cite: 3]
sudo firewall-cmd --reload [cite: 3]
Instal policycoreutils-python-utils (jika belum terinstal) dan konfigurasikan SELinux untuk port baru:

Bash

sudo dnf install policycoreutils-python-utils [cite: 3]
sudo semanage port -a -t ssh_port_t -p tcp 2022 [cite: 3]
Reboot sistem untuk menerapkan perubahan:

Bash

reboot [cite: 3]