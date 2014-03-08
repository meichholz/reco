#
# these step definitions support
# - incantation of the SUT
# - replay-scenarios
# - help-scenarios
#
# they test the logwatcher.rb module.

Given "the Application" do
  @sut = Sut::Application.new
end

When /^I start with (\-.+)$/ do |args|
  @sut.push_arg(args)
  @sut.run
end

Then "I want to see a version number" do
  @sut.output.should =~ /VERSION\n\s+\d+.\d+/
end

Then "I want to see modes and options" do
  [ 'MODES',
  'OPTIONS',
  'test : run .* test',
  ].each do |pattern|
    @sut.output.should =~ /^\s*#{pattern}$/
  end
end

Given /^a (\w+) config on ([\w\/]+)/ do |cname, dname|
  @sut.push_arg("-c conf/#{cname}")
  @sut.push_arg("< #{dname} 2>&1")
end

When "I replay" do
  @sut.push_arg("-v --no-daemon -d 1")
  @sut.run
  @sut.status.should == 0
end

When /^"(.*?)" mode is run$/ do |mode|
  @sut.push_arg(mode)
  @sut.run
  @sut.status.should == 0
end

Then "I want to see traces of action" do
  @sut.output.should =~ / starting up/
  @sut.output.should =~ / Info: no file /
end

When /^a logfile is requested in (\S+)$/ do |logname|
  @logname = logname
  @sut.push_arg("-l #{@logname}")
  temp_cleanup
end

Then "the logfile looks reasonable" do
  log = read_logfile(@logname)
  log.each { |line| line.should =~ /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} / }
  log[0].should =~ / starting up$/
  @sut.output =~ / LogWatcher::SmtpConnectionGauge : \d+\n/
  temp_cleanup
end

