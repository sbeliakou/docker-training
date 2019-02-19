/*
 * Create an admin user.
 */

import jenkins.model.*
import hudson.security.*

println "--> creating admin user"

def adminUsername = System.getenv("ADMIN_USERNAME")
def adminPassword = System.getenv("ADMIN_PASSWORD")
assert adminPassword != null : "No ADMIN_USERNAME env var provided, but required"
assert adminPassword != null : "No ADMIN_PASSWORD env var provided, but required"

println adminUsername
println adminPassword

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(adminUsername, adminPassword)
Jenkins.instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
Jenkins.instance.setAuthorizationStrategy(strategy)

Jenkins.instance.save()
