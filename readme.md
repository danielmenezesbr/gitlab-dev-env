[![CI](https://github.com/danielmenezesbr/gitlab-dev-env/workflows/CI/badge.svg)](https://github.com/danielmenezesbr/gitlab-dev-env/actions)

This repository creates a development environment for testing GitLab CE features.

| [![Gitpod ready-to-code](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/danielmenezesbr/gitlab-dev-env) | [![Open this project in Cloud Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/danielmenezesbr/gitlab-dev-env) | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=danielmenezesbr/gitlab-dev-env) |
| --- | --- | --- |
| GitPod users will have the environment automatically provisioned upon IDE startup. | To provision the environment in Google Cloud Shell, run the command `./start.sh` | Choose a machine with at least 4 cores. Github Codespaces users will have the environment automatically provisioned upon IDE startup. <br/> Jenkins becomes unstable when using only 8GB of memory in CodeSpaces (exited with 137). |

User/password to log into Gitlab will be displayed on the console when the environment is ready for use:

```
...
User / Password: root / password123456@
```

After environment provisioning, the following will be available:
 - Gitlab;
 - GitLab runner installed and configured on GitLab (registered);
 - Jenkins;
 - `my-organization/my-departament/team-a/java_project` repository configured with [Gitlab-CI pipeline](https://github.com/danielmenezesbr/helloworld/blob/master/.gitlab-ci.yml).
  - `my-organization/my-departament/team-a/java_project_jenkins` repository configured with [Jenkins pipeline](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/master/docker/003-job.groovy).
 - Groups, users (password: `password123456@`) and repositories:

 ```mermaid
graph TB;
    subgraph groups
        box1_1[my-organization] --> box1_2[my-departament]
        box1_2 --> box1_3[my-team-a]
        box1_2 --> box1_4[my-team-b]
    end
    subgraph users / role
        box2_1[developer-a1 / DEVELOPER<BR>developer-a2 / DEVELOPER<br>manager-a1 / OWNER<br>architect-a1 / MAINTAINER]
        box2_3[developer-b1 / DEVELOPER]
        box2_2[root / OWNER]
    end
    subgraph repositories / CI
        box3_1[java_project / GitLab-CI]
        box3_2[java_project_jenkins / Jenkins]
    end

box1_1 --> box2_2
box1_3 --> box2_1
box1_4 --> box2_3
box1_3 --> box3_1
box1_3 --> box3_2
 ```


# Global server hooks

Two [global server hooks](https://docs.gitlab.com/ee/administration/server_hooks.html?tab=GitLab+15.10+and+earlier#create-the-global-server-hook) are [installed](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/docker-compose.yml#L20) after the environment provisioning:
- [Global server hook written in bash](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/001-pre-receive). It's responsible for ensuring that the ```.gitlab-ci.yml``` file can only be updated by the `root` user. By default, this server hook is disabled. If you want to enable it, update the [file](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/001-pre-receive).
- [Global server hook written in Ruby](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/002-pre-receive) that ensures the security of the `.gitlab-ci.yml` file, allowing only users belonging to the group path `my-organization` to update it. This server hook is enabled by default.
