FROM phoronix/pts:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    p7zip-full \
    php-sqlite3

RUN echo "alias pts='phoronix-test-suite'" >> ~/.bashrc