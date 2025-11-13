#!/bin/bash
set -euo pipefail

# create keys
sudo sbctl create-keys

# enroll keys with microsoft vendor certs
sudo sbctl enroll-keys -m

# sign all unsigned files
sudo sbctl verify | sed -n 's/^✗ /sbctl sign -s /p' | sudo sh

# sign systemd-bootx64.efi
sudo sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
