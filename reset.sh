set -exuo pipefail
docker-compose down
sudo rm config data gitlab-runner logs -Rf
./start.sh