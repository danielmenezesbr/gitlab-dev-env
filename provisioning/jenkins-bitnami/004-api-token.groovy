import jenkins.model.*
import jenkins.security.*
import jenkins.security.apitoken.*
import jenkins.security.apitoken.ApiTokenStore
import hudson.model.*


// get the user object
User jjbUser = User.get("root", false, null)

// Verify that it has a ApiTokenProperty and create one if not (not sure if required, playing save here)
ApiTokenProperty tokenprop = jjbUser.getProperty(ApiTokenProperty.class)
if (!tokenprop){
  tokenprop = new ApiTokenProperty()
  jjbUser.addProperty(tokenprop)
}

// generate the actual new token (not a legacy one), the only parameter is the description that shows in jenkins
// the returned object has only two properties, tokenUuid and plainValue
Object token = tokenprop.addFixedNewToken("root-token", "11306be7455c0a586b88f8b758d941a2e7")

// save everything (again not sure if required)
jjbUser.save()