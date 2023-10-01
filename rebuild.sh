export OS_VERSION=$(date +%Y%m%d) BUILD_DATE=$(date)
./setenv_rgb30.sh
./scripts/clean ${1}
./scripts/build ${1}
./scripts/install ${1}
./scripts/image mkimage
