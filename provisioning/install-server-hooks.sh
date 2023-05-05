mkdir /opt/gitlab/embedded/service/gitlab-shell/hooks/
mkdir /opt/gitlab/embedded/service/gitlab-shell/hooks/pre-receive.d/
cp -a /tmp/pre-receive /opt/gitlab/embedded/service/gitlab-shell/hooks/pre-receive.d/
chmod +x /opt/gitlab/embedded/service/gitlab-shell/hooks/pre-receive.d/pre-receive