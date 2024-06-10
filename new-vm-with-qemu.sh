#add new file img
qemu-img create -f qcow mikrotik.img 256M
#boot img with file installation (.iso)
qemu-system-x86_64 mikrotik.img -cdrom mikrotik.iso -boot d
#open img with qemu
qemu-system-x86_64 mikrotik.img -boot c
