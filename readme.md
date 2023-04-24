This repository creates a development environment for testing GitLab CE features.

| [![Gitpod ready-to-code](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/danielmenezesbr/gitlab-dev-env) | [![Open this project in Cloud Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/danielmenezesbr/gitlab-dev-env) | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=danielmenezesbr/gitlab-dev-env) |
| --- | --- | --- |
| GitPod users will have the environment automatically provisioned upon IDE startup. | Google Cloud Shell users need to run `./start` to start the environment provisioning. | Codespaces users need to run `./start` to start the environment provisioning. Choose a machine with at least 4 cores. |

User/password to log into Gitlab will be displayed on the console when the environment is ready for use:

```
...
User / Password: root / password123456@
```

After environment provisioning, the following will be available:
 - Gitlab;
 - GitLab runner installed and configured on GitLab (registered);
 - root/java_project repository configured with its respective pipeline ([.gitlab-ci.yml](https://github.com/danielmenezesbr/helloworld/blob/master/.gitlab-ci.yml)).
