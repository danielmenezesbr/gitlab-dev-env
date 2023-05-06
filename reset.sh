set -exuo pipefail
docker compose down
rm -rf config/ data/ gitlab-runner/ logs/||sudo rm -rf config/ data/ gitlab-runner/ logs/||true
./start.sh