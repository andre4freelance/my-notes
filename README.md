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
sudo systemctl restart sshd
```

### If after restart ssh and still can't connect you must be reboot your machine

```bash
sudo reboot
```

## 6. Setup Juniper vQFX

### First connect interface QFX-PFE interface em1 to QFX-RE em1

### After that login to QFX-RE using following this one

User      : root
Password  : Juniper

### After login you can see to much interface config, so you can reconfig with following commands

```bash
{linecard:1}[edit]
root@SW-QFX-2# delete interfaces
{linecard:1}[edit]
root@SW-QFX-2# set interfaces em1 unit 0 family inet address 169.254.0.2/24
{linecard:1}[edit]
root@SW-QFX-2# commit
```

### After commit make sure ping to QFX-PFE is running
```bash
{linecard:1}[edit]
root@SW-QFX-1# run ping 169.254.0.1    
PING 169.254.0.1 (169.254.0.1): 56 data bytes
64 bytes from 169.254.0.1: icmp_seq=0 ttl=64 time=4.434 ms
64 bytes from 169.254.0.1: icmp_seq=1 ttl=64 time=2.544 ms
64 bytes from 169.254.0.1: icmp_seq=2 ttl=64 time=5.576 ms
^C
--- 169.254.0.1 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max/stddev = 2.544/4.185/5.576/1.250 ms
```

### If connection RE to PFE is running well, you must cek virtual chassis

```bash
{linecard:1}[edit]
root@SW-QFX-1#
```

If you stil see "linecard", the mean virtual chassis not exist

### Request reactive virtual chassis

```bash
{linecard:1}
root@SW-QFX-1> request virtual-chassis reactivate 

This member split from a virtual chassis. Please make sure that no active
switch belonging to this virtual chassis has conflicting configuration.

Do you want to continue ? [yes,no] (no) yes 
```

After request reactive virtual chassis successfully, you can relog the QFX-RE and see "linecard" replace with "master"
You can validate with this command dan make sure are same output

```bash
{master:1}
root@SW-QFX-1> show chassis fpc pic-status    
Slot 1   Online       QFX10002-36Q                                  
  PIC 0  Online       48x 10G-SFP+

{master:1}
root@SW-QFX-1> show interfaces terse          
Interface               Admin Link Proto    Local                 Remote
gr-0/0/0                up    up
pfe-1/0/0               up    up
pfe-1/0/0.16383         up    up   inet    
                                   inet6   
pfh-1/0/0               up    up
pfh-1/0/0.16383         up    up   inet    
pfh-1/0/0.16384         up    up   inet    
xe-1/0/0                up    up
xe-1/0/0.16386          up    up  
xe-1/0/1                up    up
xe-1/0/1.16386          up    up  
xe-1/0/2                up    up
xe-1/0/2.16386          up    up  
xe-1/0/3                up    up
xe-1/0/3.16386          up    up  
xe-1/0/4                up    up
xe-1/0/4.16386          up    up  
xe-1/0/5                up    up
xe-1/0/5.16386          up    up  
xe-1/0/6                up    up
xe-1/0/6.16386          up    up  
xe-1/0/7                up    up
xe-1/0/7.16386          up    up        
xe-1/0/8                up    up
xe-1/0/8.16386          up    up  
xe-1/0/9                up    up
xe-1/0/9.16386          up    up  
xe-1/0/10               up    up
xe-1/0/10.16386         up    up  
xe-1/0/11               up    up
xe-1/0/11.16386         up    up  
bme0                    up    up
bme0.0                  up    up   inet     128.0.0.1/2     
                                            128.0.0.4/2     
                                            128.0.0.17/2    
                                            128.0.0.63/2    
cbp0                    up    up
dsc                     up    up
em0                     up    up
em0.0                   up    up   eth-switch
em1                     up    up
em1.0                   up    up   inet     169.254.0.2/24  
em2                     up    up
em2.32768               up    up   inet     192.168.1.2/24  
em3                     up    up
em4                     up    up        
em4.32768               up    up   inet     192.0.2.2/24    
em5                     up    up
em6                     up    up
em7                     up    up
em8                     up    up
em9                     up    up
em10                    up    up
em11                    up    up
esi                     up    up
fti0                    up    up
gre                     up    up
ipip                    up    up
irb                     up    up
jsrv                    up    up
jsrv.1                  up    up   inet     128.0.0.127/2   
lo0                     up    up
lo0.0                   up    up   inet     10.20.20.20         --> 0/0
                                   inet6    fe80::205:860f:fc71:aa00
lo0.16385               up    up   inet    
lsi                     up    up
mtun                    up    up
pimd                    up    up
pime                    up    up        
pip0                    up    up
tap                     up    up
vme                     up    up
vtep                    up    up

{master:1}
root@SW-QFX-1> 
```
