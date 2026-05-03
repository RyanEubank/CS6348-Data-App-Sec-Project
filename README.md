Steps for installing Docker and compiling/running Phoronix Test Suite benchmarks:
1) Install docker desktop from https://www.docker.com/ or follow the instructions there.

2) Run the start script, docker will take care of the rest. This will take a few min before the container is ready and a shell is launched.

NOTE: To run tests without ASLR enabled this must be done in the host environment. Docker containers share the host memory space and cannot change this setting themselves. Use ```sudo sysctl -w kernel.randomize_va_space=0``` to disable ASLR on the host machine. DO NOT forget to reenable this after testing. Use ```cat /proc/sys/kernel/randomize_va_space``` inside the container to see if it is disabled (0 is correct).

Launch the container:
```
$ ./start.sh
```
3) Set the CFLAGS and LDFLAGS environment varaibles for the specific test you are running. For example, to run baseline tests with all
compile time defenses disabled, do:
```
$ export CFLAGS="$BASELINE_CFLAGS"
$ export LDFLAGS="$BASELINE_LDFLAGS"
```

There are several other options for different test configurations set in the environment variables passed fint the .env file. For example use CANARY_CFLAGS and CANARY_LDFLAGS to run tests with stack canaries enabled, etc.

4) Install the test you wish to run. Type ```pts install <test label>``` for either nginx-custom, openssl-custom, or opencv-custom.

5) You may check what static defenses are active in the compiled binaries by using the checksec command. Navigate to the installation folder for that specific test. For example, the to see the compiled files for the openssl-custom benchmark:
```
$ cd /ver/lib/phoronix-test-suite/installed-test/local/openssl-custom/openssl-4.0.0
```
And run checksec on the shared libraries it produced at install:
```
$ checksec --file=libcrypto.so
```
OR
```
$ checksec --file=libssl.so
```

6) Finally run the benchmark
```
$ pts run <test label>
```

You will be prompted during the run for several testing options, and for the names of the results file/run identifier to save the test results to.