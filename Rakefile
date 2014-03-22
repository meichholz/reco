load "devsupport/tasks/setup.rb"
load File.join(File.dirname(__FILE__), 'lib', 'reco.rb')
ds_configure do |c|
    c.mandatory_umask = :none
    c.editfiles = Dir["yardplay/**/*.*rb"].join(" ")
end

ds_tasks_for :ruby

File.open(".yardopts", "w") do |f|
  f.puts('--markup=markdown
--main=README.md
--hide-void-return
--default-return Unknown')
#  f.puts "-e #{File.join(ds_env.base_path, 'yard', 'me', 'plugin.rb')}"
  f.puts "-e yardplay/plugin.rb"
end

task :e => :'doc:yard' do
  sh "#{ds_env.browser} doc/Reco.html"
end

