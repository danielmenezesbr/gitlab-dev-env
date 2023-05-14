set +xu
GITLAB_EXTERNAL_URL="http://localhost:8080"
JENKINS_EXTERNAL_URL="http://localhost:8081"
if [[ ! -z "${GITPOD_WORKSPACE_URL}" ]]; then
  GITLAB_EXTERNAL_URL=${GITPOD_WORKSPACE_URL}
  GITLAB_EXTERNAL_URL=${GITLAB_EXTERNAL_URL/https:\/\//https:\/\/8080-}
  JENKINS_EXTERNAL_URL=${GITPOD_WORKSPACE_URL}
  JENKINS_EXTERNAL_URL=${JENKINS_EXTERNAL_URL/https:\/\//https:\/\/8081-}
fi
if [[ ! -z "${GOOGLE_CLOUD_SHELL}" ]]; then
  GITLAB_EXTERNAL_URL="https://shell.cloud.google.com/devshell/proxy?authuser=0&port=8080&environment_id=default"
  JENKINS_EXTERNAL_URL="https://shell.cloud.google.com/devshell/proxy?authuser=0&port=8081&environment_id=default"
fi
if [[ ! -z "${CODESPACES}" ]]; then
  GITLAB_EXTERNAL_URL="https://${CODESPACE_NAME}-8080.preview.app.github.dev"
  JENKINS_EXTERNAL_URL="https://${CODESPACE_NAME}-8081.preview.app.github.dev"
fi
printf "\n\n"
echo "GitLab: $GITLAB_EXTERNAL_URL"
echo "Jenkins: $JENKINS_EXTERNAL_URL"

echo "User / Password: root / password123456@"