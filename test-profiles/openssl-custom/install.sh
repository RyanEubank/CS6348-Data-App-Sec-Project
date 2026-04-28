#!/bin/sh
tar -xf openssl-4.0.0.tar.gz
cd openssl-4.0.0
./config $CFLAGS no-zlib
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd openssl-4.0.0
LD_LIBRARY_PATH=.:\$LD_LIBRARY_PATH ./apps/openssl speed -multi \$NUM_CPU_CORES -seconds 30 \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > openssl-custom
chmod +x openssl-custom