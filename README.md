# My Notes

This note summarizes some commands that I often use but tend to forget, so I’ve written them down here.

## 1. Installing QEMU 4.2.0

Follow the steps below to install QEMU version 4.2.0 from source:

### Step 1: Update Repository and Install Dependencies

```bash
sudo apt-get update
sudo apt-get install libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build
```

### Step 2: Download and Extract QEMU

```bash
wget https://download.qemu.org/qemu-4.2.0.tar.xz

# Extract the tarball

tar xf qemu-4.2.0.tar.xz
cd qemu-4.2.0
```

### Step 3: Configure, Compile, and Install QEMU

```bash
./configure --prefix=/opt/qemu-4.2.0
make -j$(nproc)
sudo make install
```

### Step 4: Add QEMU to PATH and Verify

```bash
echo 'export PATH=/opt/qemu-4.2.0/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
/opt/qemu-4.2.0/bin/qemu-system-x86_64 --version
```

---

## 2. Managing QEMU Virtual Machines

### Create and Boot a New Disk Image

#### Create a QCOW2 Image File

```bash
qemu-img create -f qcow2 mikrotik.img 256M
```

#### Boot VM Image with ISO Installer (e.g., Mikrotik.iso)

```bash
qemu-system-x86_64 mikrotik.img -cdrom mikrotik.iso -boot d
```

#### Boot Installed VM Image

```bash
qemu-system-x86_64 mikrotik.img -boot c
```

---

## 3. Creating a New User with sudo Access

### For Debian/Ubuntu Systems

```bash
sudo useradd -m -s /bin/bash username
sudo passwd username
sudo usermod -aG sudo username
```

### For RHEL/CentOS/Rocky Linux Systems

```bash
sudo useradd -m -s /bin/bash username
sudo passwd username
sudo usermod -aG wheel username
```

---

## 4. GitHub Setup

### Generate a New SSH Key

```bash
ssh-keygen -t rsa -b 4096
```
After public key has been generated, you can paste SSH Public Key into SSH and GPG Keys menu in your GitHub Profile

### Test SSH Connection to GitHub

```bash
ssh -T git@github.com
```

### Configure Git Global User Info

```bash
git config --global user.email "user@mail.com"
git config --global user.name "username"
```

---

## 5. Changing SSH Port on Rocky Linux

### Edit the sshd\_config File

Open the configuration file using `nano`:

```bash
sudo nano /etc/ssh/sshd_config
```

Find the line that says `#Port 22`, remove the `#` symbol, and change the port number to your desired value, for example:

```
port 2022
```

> **Note:** Do not forget to remove the `#` at the beginning of the line to enable the configuration.

### Add the New Port to firewalld

```bash
sudo firewall-cmd --permanent --add-port=2022/tcp
sudo firewall-cmd --reload
```

### Configure SELinux for the New Port

```bash
sudo dnf install policycoreutils-python-utils
sudo semanage port -a -t ssh_port_t -p tcp 2022
```

### Restart ssh service

```bash
systemctl restart sshd
```

### If after restart ssh and still can't connect you must be reboot your machine

```bash
reboot
```
