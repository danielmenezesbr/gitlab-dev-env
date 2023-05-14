set -exuo pipefail
docker exec gitlab gitlab-rails runner /tmp/gitlab-rails-script.rb

docker run -v $(pwd)/provisioning:/tmp/ansible -v /var/run/docker.sock:/var/run/docker.sock --network=gitlab-network willhallonline/ansible:2.9.27-alpine-3.14 /bin/sh -c "truncate -s 0 /etc/ansible/hosts;ansible-playbook /tmp/ansible/gitlab-ansible.yml"

docker exec gitlab gitlab-rails runner /tmp/gitlab-rails-script-after-ansible.rb

`dirname $0`/gitlab-runner-register.sh

#for debugging
#docker exec -it gitlab gitlab-rails console