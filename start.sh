set -exuo pipefail
docker build ./provisioning -t ansible &> ansible.docker.build.out
output=$(docker inspect -f '{{.State.Status}}' gitlab 2> /dev/null||true)
NEEDS_PROVISIONING=true
if [ "$output" == "running" ] ||  [ "$output" == "stopped" ]; then
  NEEDS_PROVISIONING=false
fi

docker compose up -d

if $NEEDS_PROVISIONING; then
  ./provisioning/provisioning.sh
 fi

set +xu
GITLAB_EXTERNAL_URL="http://localhost:8080"
if [[ ! -z "${GITPOD_WORKSPACE_URL}" ]]; then
  GITLAB_EXTERNAL_URL=${GITPOD_WORKSPACE_URL}
  GITLAB_EXTERNAL_URL=${GITLAB_EXTERNAL_URL/https:\/\//https:\/\/8080-}
fi
if [[ ! -z "${GOOGLE_CLOUD_SHELL}" ]]; then
  GITLAB_EXTERNAL_URL="https://shell.cloud.google.com/devshell/proxy?authuser=0&port=8080&environment_id=default"
fi
if [[ ! -z "${CODESPACES}" ]]; then
  GITLAB_EXTERNAL_URL="https://${CODESPACE_NAME}-8080.preview.app.github.dev"
fi
printf "\n\n"
echo $GITLAB_EXTERNAL_URL
echo "User / Password: root / password123456@"