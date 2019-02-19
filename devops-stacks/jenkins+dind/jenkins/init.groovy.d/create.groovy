import javaposse.jobdsl.dsl.DslScriptLoader
import javaposse.jobdsl.plugin.JenkinsJobManagement
import groovy.io.FileType

def createJob(filename) {
  def jobDslScript = new File(filename)
  def workspace = new File('.')
  def jobManagement = new JenkinsJobManagement(System.out, [:], workspace)
  new DslScriptLoader(jobManagement).runScript(jobDslScript.text)
  println "Job '" + filename + "' has been created'"
}

def dir = new File(System.getenv("JENKINS_HOME")+'/init.groovy.d/')
dir.eachFileRecurse (FileType.FILES) { jobfile ->
  if (jobfile ==~ /.*\.jobdsl$/) {
    createJob(jobfile.path)
  }
}
