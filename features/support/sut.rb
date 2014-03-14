module Sut
  class Application 
    attr_reader :output, :status
    attr_accessor :env
    def initialize
      @argv=Array.new
      @env=:test
      @status=nil
      @output=nil
      @frontend = 'bin/reco'
    end
    def push_arg(argv)
      @argv<<argv
    end
    def run(args=nil)
      if args.nil?
        args=String.new
      end
      args += " "+@argv.flatten.join(" ")
      @output=`bundle exec #{@frontend} --environment=#{@env} #{args}`
      @status=$?.exitstatus
      if $debug_app and @status!=0
        puts "app failed"
        puts @output
        return @status
      end
      if $verbose_app
        puts @output
      end
      @status
    end
  end
end
