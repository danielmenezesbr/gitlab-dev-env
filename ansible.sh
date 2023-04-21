set -exuo pipefail
docker build ./ansible -t ansible
docker exec -it gitlab-ce gitlab-rails runner "token = User.find_by_username('root').personal_access_tokens.create(scopes: ['api', 'read_api', 'read_user', 'read_repository', 'write_repository', 'sudo', 'admin_mode'], name: 'Automation token'); token.set_token('mytoken'); token.save!"
docker run -it -v $(pwd)/ansible:/tmp/ansible --network=gitlab-network ansible bash -c "ansible-playbook /tmp/ansible/gitlab.yml"
sudo cat config/initial_root_password