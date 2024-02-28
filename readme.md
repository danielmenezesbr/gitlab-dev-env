[![CI](https://github.com/danielmenezesbr/gitlab-dev-env/workflows/CI/badge.svg)](https://github.com/danielmenezesbr/gitlab-dev-env/actions)

This repository creates a development environment for testing GitLab CE features.

| [![Gitpod ready-to-code](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/danielmenezesbr/gitlab-dev-env) | [![Open this project in Cloud Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/danielmenezesbr/gitlab-dev-env) | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=danielmenezesbr/gitlab-dev-env) |
| --- | --- | --- |
| GitPod users will have the environment automatically provisioned upon IDE startup. <br/><br/> Free monthly hour limit: 50 hours. | To provision the environment in Google Cloud Shell, run the command `./start.sh` <br/><br/> Free weekly hour limit: 60 hours.| Choose a machine with at least 4 cores. Github Codespaces users will have the environment automatically provisioned upon IDE startup. <br/><br/> Jenkins becomes unstable when using only 8GB of memory in CodeSpaces (exited with 137). <br/><br/> Free monthly hour limit: 30 hours (4 cores) |

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
  - `my-organization/my-departament/team-a/java_project_jenkins` repository configured with [Jenkins pipeline](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/jenkins/003-job.groovy).
 - Groups, users (password: `password123456@`) and repositories:

[Overview](#diagram):
 ```mermaid
graph TB;
    subgraph groups
        my-organization --> my-departament
        my-departament --> my-team-a
        my-departament --> my-team-b
    end
    subgraph users / role
        users-my-team-a[developer-a1 / DEVELOPER<BR>developer-a2 / DEVELOPER<br>manager-a1 / OWNER<br>architect-a1 / MAINTAINER]
        users-my-team-b[developer-b1 / DEVELOPER]
        root[root / OWNER]
    end
    subgraph repositories
        java_project
        java_project_jenkins
    end
    subgraph CI
        GitLab-CI
        Jenkins
    end
    subgraph QA-Tools
        SonarQube
    end

my-organization --> root
my-team-a --> users-my-team-a
my-team-b --> users-my-team-b
my-team-a --> java_project
my-team-a --> java_project_jenkins
java_project --> GitLab-CI
java_project_jenkins --> Jenkins
GitLab-CI --> QA-Tools

 ```


# Global server hooks

Two [global server hooks](https://docs.gitlab.com/ee/administration/server_hooks.html?tab=GitLab+15.10+and+earlier#create-the-global-server-hook) are [installed](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/docker-compose.yml#L20) after the environment provisioning:
- [Global server hook written in bash](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/001-pre-receive). It's responsible for ensuring that the ```.gitlab-ci.yml``` file can only be updated by the `root` user. By default, this server hook is disabled. If you want to enable it, update the [file](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/001-pre-receive).
- [Global server hook written in Ruby](https://github.com/danielmenezesbr/gitlab-dev-env/blob/master/provisioning/hooks/pre-receive.d/002-pre-receive) that ensures the security of the `.gitlab-ci.yml` file, allowing only users belonging to the group path `my-organization` to update it. This server hook is enabled by default.
