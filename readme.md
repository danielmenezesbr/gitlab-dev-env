[![Open this project in Cloud
Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/danielmenezesbr/gitlab-dev-env)


[![Gitpod ready-to-code](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/danielmenezesbr/gitlab-dev-env)

```bash
./start.sh
```

```bash
++ docker-compose up -d
[+] Running 13/13
 ✔ web 8 layers [⣿⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                                                   72.3s 
   ✔ 5544ebdc0c7b Pull complete                                                                      3.2s 
   ✔ 541ceb03d99a Pull complete                                                                      7.1s 
   ✔ 7e539b7f5f33 Pull complete                                                                      9.0s 
   ✔ 2f178f0731db Pull complete                                                                      9.0s 
   ✔ 5148d9fa7904 Pull complete                                                                      9.1s 
   ✔ 759ee753154f Pull complete                                                                      9.1s 
   ✔ 677881e59115 Pull complete                                                                      9.2s 
   ✔ 491fac0204e2 Pull complete                                                                     71.2s 
 ✔ gitlab-runner 3 layers [⣿⣿⣿]      0B/0B      Pulled                                              10.1s 
   ✔ 9621f1afde84 Pull complete                                                                      1.6s 
   ✔ 2d25adf20a19 Pull complete                                                                      8.7s 
   ✔ 2f2556680230 Pull complete                                                                      8.8s 
[+] Running 3/3
 ✔ Network gitlab-network   Created                                                                  0.1s 
 ✔ Container gitlab-ce      Healthy                                                                181.5s 
 ✔ Container gitlab-runner  Started                                                                181.9s 
++ ./ansible.sh
+++ docker build ./ansible -t ansible
[+] Building 183.0s (7/7) FINISHED                                                                        
 => [internal] load .dockerignore                                                                    0.0s
 => => transferring context: 2B                                                                      0.0s
 => [internal] load build definition from Dockerfile                                                 0.0s
 => => transferring dockerfile: 495B                                                                 0.0s
 => [internal] load metadata for docker.io/library/centos:7                                          1.1s
 => [1/3] FROM docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32  4.4s
 => => resolve docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32  0.0s
 => => sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4 1.20kB / 1.20kB       0.0s
 => => sha256:dead07b4d8ed7e29e98de0f4504d87e8880d4347859d839686a31da35a3b532f 529B / 529B           0.0s
 => => sha256:eeb6ee3f44bd0b5103bb561b4c16bcb82328cfe5809ab675bb17ab3a16c517c9 2.75kB / 2.75kB       0.0s
 => => sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 76.10MB / 76.10MB     0.8s
 => => extracting sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc            3.5s
 => [2/3] RUN yum check-update;     yum install -y gcc libffi-devel python3 epel-release;     yum   40.9s
 => [3/3] RUN pip3 install --upgrade pip;     pip3 install --upgrade virtualenv;     pip3 install  123.6s
 => exporting to image                                                                              12.9s 
 => => exporting layers                                                                             12.9s 
 => => writing image sha256:c7b823d00bb90df5824e2f2bf1e14aa25914d046cdf24895cf80e19b1cbd4f82         0.0s 
 => => naming to docker.io/library/ansible                                                           0.0s 
+++ docker exec -it gitlab-ce gitlab-rails runner 'token = User.find_by_username('\''root'\'').personal_access_tokens.create(scopes: ['\''api'\'', '\''read_api'\'', '\''read_user'\'', '\''read_repository'\'', '\''write_repository'\'', '\''sudo'\'', '\''admin_mode'\''], name: '\''Automation token'\''); token.set_token('\''mytoken'\''); token.save!'
++++ pwd
+++ docker run -it -v /workspace/gitlab-dev-env/ansible:/tmp/ansible --network=gitlab-network ansible bash -c 'ansible-playbook /tmp/ansible/gitlab.yml'
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 
2.12. Current version: 3.6.8 (default, Nov 16 2020, 16:55:22) [GCC 4.8.5 20150623 (Red Hat 4.8.5-44)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by 
setting deprecation_warnings=False in ansible.cfg.
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost
does not match 'all'

PLAY [localhost] *****************************************************************************************

TASK [Gathering Facts] ***********************************************************************************
ok: [localhost]

TASK [python-gitlab] *************************************************************************************
changed: [localhost]

TASK [Create a GitLab Project using a username/password via oauth_token] *********************************
changed: [localhost]

PLAY RECAP ***********************************************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

+++ sudo cat config/initial_root_password
# WARNING: This value is valid only in the following conditions
#          1. If provided manually (either via `GITLAB_ROOT_PASSWORD` environment variable or via `gitlab_rails['initial_root_password']` setting in `gitlab.rb`, it was provided before database was seeded for the first time (usually, the first reconfigure run).
#          2. Password hasn't been changed manually, either via UI or via command line.
#
#          If the password shown here doesn't work, you must reset the admin password following https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password.

Password: D8TLCdi1miIB+W1LuC+PhMuTb/ZXjoijPvXZSoPsvtQ=

# NOTE: This file will be automatically deleted in the first reconfigure run after 24 hours.
```