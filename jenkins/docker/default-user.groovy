import hudson.security.*

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "password123456@")
instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()
// import jenkins.model.*
// import hudson.security.*

// def env = System.getenv()

// def jenkins = Jenkins.getInstance()
// if(!(jenkins.getSecurityRealm() instanceof HudsonPrivateSecurityRealm))
//     jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))

// if(!(jenkins.getAuthorizationStrategy() instanceof GlobalMatrixAuthorizationStrategy))
//     jenkins.setAuthorizationStrategy(new GlobalMatrixAuthorizationStrategy())

// def user = jenkins.getSecurityRealm().createAccount(env.JENKINS_USER, env.JENKINS_PASS)
// user.save()
// jenkins.getAuthorizationStrategy().add(Jenkins.ADMINISTER, env.JENKINS_USER)

// jenkins.save()
