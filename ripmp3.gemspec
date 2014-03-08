# vim: ft=ruby:
require File.join(File.dirname(__FILE__),'lib','ripmp3','version.rb')

Gem::Specification.new do |s|
  s.name = "ripmp3"
  s.version = Ripmp3::VERSION # find in lib/logwatcher/version.rb
  s.platform = Gem::Platform::RUBY
  s.authors = ["Marian Eichholz"]
  s.email = ["marian@bugslayer.de"]
  # s.homepage = "https://giles.bugslayer.de/jenkins/wml"
  s.summary = %q{Utility for MP3 album creation from WAV}
  s.description = %q{see README.md}
  s.files = Dir['lib/**.rb']
  s.files << 'bin/wml'
  s.executables << s.name
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.add_development_dependency('rake')
  s.add_development_dependency('ronn')
  s.add_development_dependency('rspec')
  s.add_development_dependency('cucumber')
  s.add_development_dependency('yard')
end

