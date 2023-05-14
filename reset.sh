set -exuo pipefail
docker compose down -v
rm -rf config/ data/ gitlab-runner/ logs/ jenkins_home/||sudo rm -rf config/ data/ gitlab-runner/ logs/ jenkins_home/||true
docker compose build
./start.sh