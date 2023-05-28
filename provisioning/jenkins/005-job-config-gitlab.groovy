import jenkins.model.*
import hudson.model.*
import hudson.tasks.*
import org.jenkinsci.plugins.workflow.job.*
import org.jenkinsci.plugins.workflow.cps.*
import jenkins.model.*
import hudson.plugins.git.*

def jobName = "ConfigGitLab"
def jenkins = Jenkins.getInstance()
def pipelineJob = jenkins.createProject(WorkflowJob.class, jobName)

def pipelineScript = '''
pipeline {
    agent any

    stages {
        stage('Create/Protect Branches') {
            steps {
                script {
                    def gitLabUrl = 'http://web/'
                    def personalAccessToken = 'token-string-here321'
                    def repositories = ['my-organization/my-departament/team-a/java_project', 'my-organization/my-departament/team-a/java_project_jenkins']
                    def sourceBranch = 'main'
                    def branches = ['homologation', 'production']

                    repositories.each { repository ->
                        branches.each { branchName ->
                            createBranch(gitLabUrl, personalAccessToken, repository, branchName, sourceBranch)
                            protectBranch(gitLabUrl, personalAccessToken, repository, branchName)
                        }
                    }
                }
            }
        }
    }
}

def createBranch(String gitLabUrl, String personalAccessToken, String repository, String branchName, String sourceBranch) {
    def apiUrl = "${gitLabUrl}/api/v4/projects/${URLEncoder.encode(repository, 'UTF-8')}/repository/branches?branch=${branchName}&ref=${sourceBranch}"
    
    httpRequest consoleLogResponseBody: true,
        httpMode: 'POST',
        contentType: 'APPLICATION_JSON',
        customHeaders: [[name: 'Private-Token', value: personalAccessToken]],
        url: apiUrl
    
    echo "A branch '${branchName}' foi criada com sucesso no repositório '${repository}'!"
}

// https://docs.gitlab.com/ee/api/protected_branches.html#protect-repository-branches
def protectBranch(String gitLabUrl, String personalAccessToken, String repository, String protectedBranch) {
    //curl --request POST --header "PRIVATE-TOKEN: <your_access_token>" "https://gitlab.example.com/api/v4/projects/5/protected_branches?name=*-stable&push_access_level=30&merge_access_level=30&unprotect_access_level=40"
    def apiUrl = "${gitLabUrl}/api/v4/projects/${URLEncoder.encode(repository, 'UTF-8')}/protected_branches?name=${protectedBranch}"

    httpRequest consoleLogResponseBody: true,
        httpMode: 'POST',
        contentType: 'APPLICATION_JSON',
        customHeaders: [[name: 'Private-Token', value: personalAccessToken]],
        url: apiUrl
    
    echo "A branch '${protectedBranch}' foi protegida com sucesso no repositório '${repository}'!"
}
'''

def pipelineScriptDef = new CpsFlowDefinition(pipelineScript, true)

pipelineJob.setDefinition(pipelineScriptDef)

pipelineJob.save()