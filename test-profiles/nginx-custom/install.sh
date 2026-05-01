#!/bin/bash

mkdir $HOME/nginx_

tar -xf http-test-files-1.tar.xz
tar -xf nginx-1.21.1.tar.gz

cd nginx-1.21.1/
./configure --prefix=$HOME/nginx_ --without-http_rewrite_module --without-http-cache --with-cc-opt="$CFLAGS" --with-ld-opt="$LDFLAGS"
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
make install
cd ~
rm -rf nginx-1.21.1/

sed -i "s/worker_processes  1;/#worker_processes auto;/g" nginx_/conf/nginx.conf
sed -i -E "s/ listen\s+80;/ listen 8089;/g" nginx_/conf/nginx.conf

mv -f http-test-files/* nginx_/html/

echo "#!/bin/sh
/root/go/bin/bombardier \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > nginx-custom

chmod +x nginx-custom