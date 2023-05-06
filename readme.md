[![CI](https://github.com/danielmenezesbr/gitlab-dev-env/workflows/CI/badge.svg)](https://github.com/danielmenezesbr/gitlab-dev-env/actions)

This repository creates a development environment for testing GitLab CE features.

| [![Gitpod ready-to-code](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/danielmenezesbr/gitlab-dev-env) | [![Open this project in Cloud Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/danielmenezesbr/gitlab-dev-env) | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=danielmenezesbr/gitlab-dev-env) |
| --- | --- | --- |
| GitPod users will have the environment automatically provisioned upon IDE startup. | To provision the environment in Google Cloud Shell, run the command `./start.sh` | To provision the environment in Codespaces, run the command `./start.sh`. Choose a machine with at least 4 cores. |

User/password to log into Gitlab will be displayed on the console when the environment is ready for use:

```
...
User / Password: root / password123456@
```

After environment provisioning, the following will be available:
 - Gitlab;
 - GitLab runner installed and configured on GitLab (registered);
 - `my-organization/my-departament/team-a/java_project` repository configured with its respective pipeline ([.gitlab-ci.yml](https://github.com/danielmenezesbr/helloworld/blob/master/.gitlab-ci.yml)).
 - Groups and users (password: `password123456@`):

 ```mermaid
graph TB;
    subgraph groups
        box1_1[my-organization] --> box1_2[my-departament]
        box1_2 --> box1_3[my-team-a]
        box1_2 --> box1_4[my-team-b]
    end
    subgraph users
        box2_1[developer-a1<BR>developer-a2<br>manager-a1<br>architect-a1]
        box2_2[root]
        box2_3[developer-b1]
    end

box1_1 --> box2_2
box1_3 --> box2_1
box1_4 --> box2_3
 ```


# Global server hooks

Two [global server hooks](https://docs.gitlab.com/ee/administration/server_hooks.html?tab=GitLab+15.10+and+earlier#create-the-global-server-hook) are [installed](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/docker-compose.yml#L20) after the environment provisioning:
- [Global server hook written in bash](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/001-pre-receive). It's responsible for ensuring that the ```.gitlab-ci.yml``` file can only be updated by the `root` user. By default, this server hook is disabled. If you want to enable it, update the [file](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/001-pre-receive).
- [Global server hook written in Ruby](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/002-pre-receive) that ensures the security of the `.gitlab-ci.yml` file, allowing only users belonging to the group path `my-organization` to update it. This server hook is enabled by default.
