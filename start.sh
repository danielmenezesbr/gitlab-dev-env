set -exuo pipefail
output=$(docker inspect -f '{{.State.Status}}' gitlab 2> /dev/null||true)
NEEDS_PROVISIONING=true
if [ "$output" == "running" ] ||  [ "$output" == "stopped" ]; then
  NEEDS_PROVISIONING=false
fi

n=0
until [ "$n" -ge 10 ]
do
   docker compose up -d && break
   n=$((n+1)) 
   sleep 30
done

if $NEEDS_PROVISIONING; then
  ./provisioning/provisioning.sh
 fi

./show.sh