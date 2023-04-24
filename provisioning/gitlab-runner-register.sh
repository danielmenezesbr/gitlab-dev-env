set -exuo pipefail
token=$(docker exec -t gitlab gitlab-rails runner "puts Gitlab::CurrentSettings.current_application_settings.runners_registration_token")
token="${token//$'\r'/}"
docker exec -t gitlab-runner gitlab-runner register \
    --non-interactive \
    --url http://web/ \
    --registration-token $token \
    --executor docker \
        --name=private-runner-dev \
        --run-untagged  \
        --docker-privileged=true \
        --docker-network-mode gitlab-network \
        --docker-image=maven:latest \
    --tag-list "private-runner"