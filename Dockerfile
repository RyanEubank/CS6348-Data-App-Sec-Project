FROM phoronix/pts:latest

ENV DEBIAN_FRONTEND=noninteractive

# Cconvienience alias, "phoronix-test-suite" is a lot to type :(
RUN echo "alias pts='phoronix-test-suite'" >> ~/.bashrc

# Install external dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget

# Install latest version of golang via direct download - apt package is too old
RUN wget -o /usr/local/go1.26.2.linux-amd64.tar.gz https://go.dev/dl/go1.26.2.linux-amd64.tar.gz
RUN sudo tar -C /usr/local -xzf go1.26.2.linux-amd64.tar.gz && rm -rf /usr/localgo1.26.2.linux-amd64.tar.gz
RUN /usr/local/go/bin/go install github.com/codesenberg/bombardier@latest

# Copy over test profiles and script fixes
RUN cp -va /var/lib/phoronix-test-suite/test-profiles/pts/nginx-2.0.1 /var/lib/phoronix-test-suite/test-profiles/local/nginx-custom
WORKDIR /var/lib/phoronix-test-suite/test-profiles/local/nginx-custom
COPY ./test-profiles/nginx-custom/install.sh ./install.sh
COPY ./test-profiles/nginx-custom/test-definition.xml ./test-definition.xml

WORKDIR /root
