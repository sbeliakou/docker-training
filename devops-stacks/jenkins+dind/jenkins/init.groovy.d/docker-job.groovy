import jenkins.model.Jenkins;
import hudson.model.FreeStyleProject;
import hudson.tasks.Shell;

job = Jenkins.instance.createProject(FreeStyleProject, 'docker-job')
job.buildersList.add(new Shell('docker run --rm hello-world'))
job.save()

build = job.scheduleBuild2(5, new hudson.model.Cause.UserIdCause())
build.get()

generatedJobs = build.getAction(javaposse.jobdsl.plugin.actions.GeneratedJobsBuildAction).getItems()
generatedJobs.each {
  j -> j.scheduleBuild2(5, new hudson.model.Cause.UserIdCause())
}
