module Reco
  class Options
    @writables = %w[debugmask]
    @nonwritables = %w[
  environment
  mode
  verbose
    ]
    @nonwritables.each { |sym| attr_accessor sym }
    @writables.each { |sym| attr_accessor sym }

    class << self
      attr_reader :nonwritables, :writables
    end
    def initialize
      @verbose = false
      @environment = :production
      @mode = :unknown
      @debugmask = 0
    end
  end

  class Configuration
    extend Forwardable

    @debug_masks={
      :wip        => 0x0001,
      :configfile => 0x0002,
      :all        => 0xFFFF,
    }
    class << self
      attr_reader :debug_masks

      # @todo Klein
      def debug_mask_options(indentation="",trailer="")
        s=String.new
        @debug_masks.each do |key,value|
          s<<sprintf("%s0x%04x : %s%s\n", indentation, value, key.to_s, trailer )
        end
        s
      end
      # @TODO gross
      def debug_flag(sym) # abstractor helper for testing code
        @debug_masks[sym]
      end
      def debugging?(what)
        mask=Configuration.debug_masks[what]
        return false if mask.nil? 
        (@opt.debugmask & mask) == mask
      end
    end # class func

    Options.nonwritables.each { |sym| def_delegators :@opt, sym }
    Options.writables.each { |sym| def_delegators :@opt, sym, (sym.to_s+"=").to_sym }
    def initialize(parsed_options, with_file = true)
      @opt = parsed_options.clone # do not overwrite original settings
    end

  end

  class App
    def initialize
    end

    def setup_config(argv)
      Helper.configuration = Configuration.new(self.class.commandline_options(argv))
    end

    def setup(argv)
      setup_config(argv)
    end

    def run(mode)
      $stdout.sync = true
      $stderr.sync = true
      case mode
      when 'test'
        puts "running quick test"
      else
        Helper.panic "Unknown MODE, try '#{Helper.name} help'"
      end
    end

    def self.commandline_options(argv)
      opt=Options.new
      parser=OptionParser.new do |o|
        o.banner = 'Usage: '+Helper.name+' {OPTIONS} [MODE]
  VERSION
    '+Helper.version+'

  MODES
    test : run quick self test
    (default) : read from stdin

  OPTIONS'
        o.on('-v', '--verbose', 'verbosity on') { opt.verbose = true }
        o.on('-e', '--environment ENV', String, 'choose runtime context') { |env| opt.environment = env.to_sym }
      end
      begin
        parser.parse! argv
        puts parser if argv[0]=='help'
      rescue OptionParser::ParseError => err
        Helper.panic parser, "\nFATAL: #{err}"
      end
      return opt
    end
  end
end
