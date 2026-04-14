if [ "$#" -gt 1 ]; then
    echo "Usage: ./start.sh < --phoromatic >"
    exit 1
fi

docker compose build
docker compose up -d

if [ "$1" == "--phoromatic" ]; then
    docker exec benchmark_container phoronix-test-suite start-phoromatic-server > /dev/null 2>&1 & docker attach benchmark_container
else
    docker attach benchmark_container
fi
