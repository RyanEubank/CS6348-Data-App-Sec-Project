#!/bin/sh
tar -xf openssl-4.0.0.tar.gz
cd openssl-4.0.0

if [[ "$CFLAGS" == "$BASELINE_CFLAGS" ]]; then
    ./Configure no-zlib CFLAGS="-fPIC -fno-stack-protector" LDFLAGS="-z execstack"
elif [[ "$CFLAGS" == "$CANARY_CFLAGS" ]]; then 
    ./Configure no-zlib CFLAGS="-fPIC" LDFLAGS="-z execstack"
elif [[ "$CFLAGS" == "$DEP_CFLAGS" ]]; then 
    ./Configure no-zlib CFLAGS="-fPIC -fno-stack-protector" LDFLAGS=""
elif [[ "$CFLAGS" == "$PIE_CFLAGS" ]]; then 
    ./Configure no-zlib CFLAGS="-fPIC -fno-stack-protector" LDFLAGS="-z execstack"
else
    ./Configure no-zlib CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
fi

make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd openssl-4.0.0
LD_LIBRARY_PATH=.:\$LD_LIBRARY_PATH ./apps/openssl speed -multi \$NUM_CPU_CORES -seconds 30 \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > openssl-custom
chmod +x openssl-custom