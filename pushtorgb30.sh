# Replace with your device values
HOST=192.168.0.108
DEVICE=RK3566
ARCH=aarch64

# Assume today is the same UTC day that the image was built
TIMESTAMP=$(date -u +%Y%m%d)

SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
scp ${SSH_OPTS} ~/distribution/release/JELOS-${DEVICE}.${ARCH}-${TIMESTAMP}.tar root@${HOST}:~/.update && ssh ${SSH_OPTS} root@${HOST} reboot
