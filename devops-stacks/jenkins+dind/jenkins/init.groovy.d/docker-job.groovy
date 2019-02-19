import jenkins.model.Jenkins;
import hudson.model.FreeStyleProject;
import hudson.tasks.Shell;

import hudson.plugins.ansicolor.AnsiColorBuildWrapper
ansiColorWrapper = new AnsiColorBuildWrapper("xterm")

job = Jenkins.instance.createProject(FreeStyleProject, 'docker-freestyle-job')
job.getBuildWrappersList().add(ansiColorWrapper)
job.buildersList.add(new Shell('docker run --rm hello-world'))
job.save()

build = job.scheduleBuild2(5, new hudson.model.Cause.UserIdCause())
build.get()
