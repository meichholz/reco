load "devsupport/tasks/setup.rb"
ds_tasks_for :hoe

projectname = ds_env.program_name
load File.join(File.dirname(__FILE__), 'lib', projectname, 'version.rb')

Hoe.plugins.delete :test # needs some more working integration
# http://rubydoc.info/github/seattlerb/hoe/Hoe/Test
^
Hoe.spec projectname do
  developer "Marian Eichholz", "marian@bugslayer.de"
  ds_env.dev_deps.each do |spec|
    extra_dev_deps << spec
  end
  license ds_env.license
  ds_env.yard_options.each do |opt|
    self.yard_options += opt
  end
end

namespace :run do
  # construct rake tasks for each command
  %w(wip).each do |command|
    desc "Command: #{command}"
    task command do |t|
      command = t.to_s.gsub(/^.*:/,"")
      sh "bundle exec #{ds_env.frontend} #{command}"
    end
  end
  # standard interface feature calls
  desc "Show empty help"
  task :bare do
    sh "bundle exec #{ds_env.frontend}"
  end
  desc "Show help"
  task :help do
    sh "bundle exec #{ds_env.frontend} -h"
  end
  desc "Show version"
  task :version do
    sh "bundle exec #{ds_env.frontend} -V"
  end

end

