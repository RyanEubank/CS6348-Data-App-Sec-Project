Steps for installing Docker and compiling/running Phoronix Test Suite benchmarks:
1) Install docker desktop from https://www.docker.com/
2) Create and run a docker container with the official phoronix image:
```
$ docker run -it phoronix/pts /bin/bash
```

3) Inside the container, update and install required packages:
```
$ apt-get update && apt-get install make
```

4) Update the PATH environment variable to include /phoronix-test-suite:
```
$ export PATH="$PATH:/phoronix-test-suite"
```

5) Set compiler and compiler flags by exporting options for make:
```
$ export CC="gcc"
$ export CFLAGS="<whatever flags we want to use>"
```

6) Run a benchmark, for example the 7zip benchmark:
```
$ phoronix-test-suite benchmark compress-7zip
```

The pts build should automatically detect changes to environment variables, but in case other runs do not change force reinstalling the tests with:
```
$ CC=<C compiler> CXX=<C++ compiler> CFLAGS=<your flags> phoronix-test-suite force-install compress-7zip
```
Then run the benchmark again (Step 6)

7) See results again with:
```
$ phoronix-test-suite info <result_identifier>
``` 