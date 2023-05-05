set -exuo pipefail
output=$(docker inspect -f '{{.State.Status}}' gitlab 2> /dev/null||true)
NEEDS_PROVISIONING=true
if [ "$output" == "running" ] ||  [ "$output" == "stopped" ]; then
  NEEDS_PROVISIONING=false
fi

docker compose up -d

if $NEEDS_PROVISIONING; then
  docker build ./provisioning -t ansible &> ansible.docker.build.out
  ./provisioning/provisioning.sh
 fi

./show.sh