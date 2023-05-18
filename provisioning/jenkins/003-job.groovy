import jenkins.model.*
import hudson.model.*
import hudson.tasks.*
import org.jenkinsci.plugins.workflow.job.*
import org.jenkinsci.plugins.workflow.cps.*
import jenkins.model.*
import hudson.plugins.git.*
import com.dabsquared.gitlabjenkins.*
import com.dabsquared.gitlabjenkins.connection.GitLabConnection
import com.dabsquared.gitlabjenkins.connection.GitLabConnectionProperty

def jobName = "MeuJobDePipeline"
def jenkins = Jenkins.getInstance()
def pipelineJob = jenkins.createProject(WorkflowJob.class, jobName)

def pipelineScript = '''
node() {

    gitlabBuilds(builds: ["build", "test"]) {
        stage("build") {
          gitlabCommitStatus("build") {
              // your build steps
          }
        }

        stage("test") {
          gitlabCommitStatus("test") {
              // your test steps
          }
        }
    }
}
'''

def pipelineScriptDef = new CpsFlowDefinition(pipelineScript, true)

pipelineJob.setDefinition(pipelineScriptDef)
//def pipelineSCM = new SCMStep('')
//pipelineJob.setScm(pipelineSCM)

def gitLabConnectionName = "my-gitlab-conn"
pipelineJob.addProperty(new GitLabConnectionProperty(gitLabConnectionName))
pipelineJob.addTrigger(new com.dabsquared.gitlabjenkins.GitLabPushTrigger())

pipelineJob.save()