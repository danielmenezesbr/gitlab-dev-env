FROM jenkins/jenkins:2.387.3-lts-jdk11
ENV JENKINS_USER admin
ENV JENKINS_PASS password123456@
USER jenkins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
#RUN jenkins-plugin-cli --plugins pipeline-model-definition github-branch-source gitlab-plugin:1.7.12
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt