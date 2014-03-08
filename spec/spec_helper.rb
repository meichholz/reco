
require 'simplecov'
require 'simplecov-rcov'
require 'ci/reporter/rake/rspec_loader'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start

load File.join(File.dirname(__FILE__),'..','lib','ripmp3.rb')

$-w=false # set it back here, elseway rspec gets strange warning(s).

# set a place to store global fixtures
class GlobalFixtures
  @cli_options = nil
  @mocker = nil;
  class << self
    attr_accessor :cli_options, :mocker
  end
end

# build test environment without touching ARGV
GlobalFixtures.cli_options=WML::WML.commandline_options(['-e', 'special' ]) # sets the stage for config_spec.rb
WML::App.configuration = WML::Configuration.new(GlobalFixtures.cli_options)
# WML::App.logger = WML::Logger.new(WML::App.configuration.logfilename)
WML::App.configuration.debugmask = WML::Configuration.debug_flag(:wip)

