import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl
import com.dabsquared.gitlabjenkins.connection.GitLabApiTokenImpl
import hudson.util.Secret
import jenkins.model.*
import com.dabsquared.gitlabjenkins.connection.GitLabConnectionConfig
import com.dabsquared.gitlabjenkins.connection.GitLabConnection
import com.dabsquared.gitlabjenkins.gitlab.api.impl.AutodetectGitLabClientBuilder

def apiToken = Secret.fromString("mytoken")
def id = "gitlab-credentials";
def gitlabHostUrl = "http://web"
description = "gitlab-credentials"

def domain = Domain.global()

def credentials = new GitLabApiTokenImpl(CredentialsScope.GLOBAL, id, description, apiToken)

CredentialsProvider.lookupStores(Jenkins.getInstance()).each { store ->
    store.addCredentials(domain, credentials)
}

Jenkins.getInstance().save()




def jenkins = Jenkins.getInstance()

def gitlabPluginConfig = jenkins.getDescriptorByType(GitLabConnectionConfig.class)
def connection = new GitLabConnection("my-gitlab-conn", "http://web", "gitlab-credentials", new AutodetectGitLabClientBuilder(), true, 10, 10)
gitlabPluginConfig.addConnection(connection);

gitlabPluginConfig.save()

