./start

++ docker-compose up -d
[+] Running 2/2
 ✔ Container gitlab-ce      Healthy                                                                                       0.5s 
 ✔ Container gitlab-runner  Running                                                                                       0.0s 
++ ./ansible.sh
+++ docker build ./ansible -t ansible
[+] Building 0.6s (7/7) FINISHED                                                                                               
 => [internal] load .dockerignore                                                                                         0.0s
 => => transferring context: 2B                                                                                           0.0s
 => [internal] load build definition from Dockerfile                                                                      0.0s
 => => transferring dockerfile: 495B                                                                                      0.0s
 => [internal] load metadata for docker.io/library/centos:7                                                               0.6s
 => [1/3] FROM docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4         0.0s
 => CACHED [2/3] RUN yum check-update;     yum install -y gcc libffi-devel python3 epel-release;     yum install -y pyth  0.0s
 => CACHED [3/3] RUN pip3 install --upgrade pip;     pip3 install --upgrade virtualenv;     pip3 install pywinrm[kerbero  0.0s
 => exporting to image                                                                                                    0.0s
 => => exporting layers                                                                                                   0.0s
 => => writing image sha256:bd896420d03189850b8515125022a3bf2733ae4e6ce47f9a93f8ff5461a08dd2                              0.0s
 => => naming to docker.io/library/ansible                                                                                0.0s
+++ docker exec -it gitlab-ce gitlab-rails runner 'token = User.find_by_username('\''root'\'').personal_access_tokens.create(scopes: ['\''api'\'', '\''read_api'\'', '\''read_user'\'', '\''read_repository'\'', '\''write_repository'\'', '\''sudo'\'', '\''admin_mode'\''], name: '\''Automation token'\''); token.set_token('\''mytoken'\''); token.save!'
++++ pwd
+++ docker run -it -v /workspace/gitlab-dev-env/ansible:/tmp/ansible --network=gitlab-network ansible bash -c 'ansible-playbook /tmp/ansible/gitlab.yml'
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version:
 3.6.8 (default, Nov 16 2020, 16:55:22) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. This feature will be removed from ansible-
core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [localhost] **************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************
ok: [localhost]

TASK [python-gitlab] **********************************************************************************************************
changed: [localhost]

TASK [Create a GitLab Project using a username/password via oauth_token] ******************************************************
changed: [localhost]

PLAY RECAP ********************************************************************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

+++ sudo cat config/initial_root_password
# WARNING: This value is valid only in the following conditions
#          1. If provided manually (either via `GITLAB_ROOT_PASSWORD` environment variable or via `gitlab_rails['initial_root_password']` setting in `gitlab.rb`, it was provided before database was seeded for the first time (usually, the first reconfigure run).
#          2. Password hasn't been changed manually, either via UI or via command line.
#
#          If the password shown here doesn't work, you must reset the admin password following https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password.

Password: K0vYoOA/gxBG9N8bzuAKgBr37llJIaag9SD9Xyi2Ryo=

# NOTE: This file will be automatically deleted in the first reconfigure run after 24 hours.


[![Open this project in Cloud
Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/danielmenezesbr/gitlab-dev-env)


[![Gitpod ready-to-code](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/danielmenezesbr/gitlab-dev-env)
