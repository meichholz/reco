# requires 'command.rb' for command infrastructure

# @alltodos
module Reco

  class App

    include_helpers

    def initialize
      @opt = OpenStruct.new
      _set_defaults
    end

    def setup(argv)
      setup_commandline(argv)
    end

    # @param [Symbol] effective_mode the main mode
    # @return self
    def run(effective_mode=nil)
      $stdout.sync = true
      $stderr.sync = true
      effective_mode ||= @mode
      #procedure = self.class.command_proc(effective_mode) or panic "unknown command`#{effective_mode}'"
      #procedure.call @params
      case effective_mode
      when :wip
        puts "running quick test"
      else
        Helper.panic "Unknown command, try '#{Helper.name} help'"
      end
      self
    end

    def setup_commandline(argv)
      parser = OptionParser.new do |o|
        o.banner = self.class.banner
        o.on('-v', '--verbose', 'verbosity on') { config.verbose = true }
        # @todo allow symbolic and arithmetic debugflags: -d json+wip
        o.on('-d', '--debug NUMBER', Numeric, 'set debugging flags') { |v| config.debugmask = v }
        o.on('-e', '--environment',"=#{@opt.environment}", String, 'choose runtime context') { |env| @opt.environment = env.to_sym }
        o.on('-h', '--help', 'help') { puts parser ; exit 0 }
        o.on('-V', '--version', 'show program version and exit') { puts VERSION ; exit 0 }
      end
      begin
        parser.parse! argv
        @mode = nil
        @params = []
        if argv[0] and argv[0]!=''
          @mode = argv.shift.to_sym
          @params = argv
        else
          STDERR.puts parser,"\n"
          panic "command required"
        end
      rescue OptionParser::ParseError => err
        STDERR.puts parser,"\n"
        panic err
      end
      self
    end

    # @todo implement a simple, active, config file for initialisation
    def _set_defaults
      config.verbose = false
      config.debugmask = 0
      @opt.environment = :test
    end

    class << self

      # @return [String] The complete application banner for the parser
      def banner
        indentation = " "*4
        return 'Usage: ' + NAME + ' {OPTIONS} [COMMAND]

  VERSION
    ' + VERSION + '

  COMMANDS' + command_list(indentation) +'
  DEBUG FLAGS' + debug_mask_list(indentation)+'
  OPTIONS'
      end
      
      private

      def command_list(indentation="")
        s = String.new
        s << "\n"
        # @todo get maximal token length for formatting
        @command_short_desc.each_pair do |token, short_desc|
          s += sprintf("%s%-8s: %s\n",
            indentation,
            token,
            short_desc)
        end
        return s
      end
      # @return [String] debug mask options suitable for a banner
      def debug_mask_list(indentation="",trailer="")
        s = String.new
        s << "\n"
        Helper::DebugMasks.each do |key,value|
          s<<sprintf("%s0x%04x : %s%s\n", indentation, value, key.to_s, trailer )
        end
        return s
      end

    end
  end
end
