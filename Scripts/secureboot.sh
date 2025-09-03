#!/bin/bash
set -euo pipefail

# create keys (safe to rerun)
sudo sbctl create-keys

# enroll keys with microsoft vendor certs
sudo sbctl enroll-keys -m

# sign all unsigned files
sudo sbctl verify | sed -n 's/^✗ /sbctl sign -s /p' | sudo sh

