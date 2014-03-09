# vim: ft=ruby:

projectname = File.basename(__FILE__, ".gemspec")
require File.join(File.dirname(__FILE__), 'lib', projectname, 'version.rb')
modulename = Reco

Gem::Specification.new do |s|
  s.summary = %q{Utility for MP3 album creation from WAV}
  s.name = projectname
  s.executables << projectname
  s.files = Dir['lib/**.rb']
  s.files << File.join('bin', projectname)
  s.version = modulename::VERSION # find in lib/logwatcher/version.rb
  # rest should be standard
  s.platform = Gem::Platform::RUBY
  s.authors = ["Marian Eichholz"]
  s.email = ["marian@bugslayer.de"]
  s.homepage = "https://giles.bugslayer.de/jenkins/#{projectname}"
  s.description = %q{see README.md}
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.add_development_dependency('rake')
  # s.add_development_dependency('ronn')
  s.add_development_dependency('rspec')
  s.add_development_dependency('cucumber')
end

