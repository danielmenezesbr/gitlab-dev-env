set -exuo pipefail
token=$(docker exec -t gitlab gitlab-rails runner "puts Gitlab::CurrentSettings.current_application_settings.runners_registration_token")
token="${token//$'\r'/}"
n=0
until [ "$n" -ge 10 ]
do
   docker exec -t gitlab-runner gitlab-runner register \
    --non-interactive \
    --url http://web/ \
    --registration-token $token \
    --executor docker \
        --name=private-runner-dev \
        --run-untagged  \
        --docker-privileged=true \
        --docker-network-mode gitlab-network \
        --docker-image=intension/docker-dind-maven:3.8.5-r0-openjdk17 \
        --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
    --tag-list "private-runner" && break
   n=$((n+1)) 
   sleep 30
done
