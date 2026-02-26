#!/bin/bash

# 1. Clone the Tegra-compatible fork
cd /tmp
git clone https://github.com/devatcratustech/wireguard-linux-compat.git
cd wireguard-linux-compat/src

# 2. Build the kernel module
make -j$(nproc) -C /lib/modules/$(uname -r)/build M=$(pwd)

# 3. Install the module
sudo cp wireguard.ko /lib/modules/$(uname -r)/kernel/net/
sudo depmod -a

# 4. Load the module
sudo modprobe wireguard

# 5. Verify
lsmod | grep wireguard
# Expected output: wireguard  139264  0

# 6. Auto-load on boot
echo "wireguard" | sudo tee /etc/modules-load.d/wireguard.conf
