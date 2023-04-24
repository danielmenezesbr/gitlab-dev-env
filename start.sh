set -exuo pipefail
docker build ./provisioning -t ansible &> ansible.docker.build.out &
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
printf "\n\n"
gp url 8080 2> /dev/null||true
if [[ ! -z "${GOOGLE_CLOUD_SHELL}" ]]; then
  echo "https://shell.cloud.google.com/devshell/proxy?authuser=0&port=8080&environment_id=default"
fi
if [[ ! -z "${CODESPACES}" ]]; then
  echo "https://${CODESPACE_NAME}-8080.preview.app.github.dev/"
fi

echo "User / Password: root / password123456@"