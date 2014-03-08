module Ripmp3
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
      :signals    => 0x0002,
      :server     => 0x0004,
      :configfile => 0x0010,
      :lockmail   => 0x0011,
      :replay     => 0x0012,
      :all        => 0xFFFF,
    }
    class << self
      attr_reader :debug_masks

      def debug_mask_options(indentation="",trailer="")
        s=String.new
        @debug_masks.each do |key,value|
          s<<sprintf("%s0x%04x : %s%s\n", indentation, value, key.to_s, trailer )
        end
        s
      end
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

  class Frontend
    def initialize
    end

    def setup_config(argv)
      App.configuration = Configuration.new(Frontend.commandline_options(argv))
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
        App.panic "Unknown MODE, try '#{App.name} help'"
      end
    end

    def self.commandline_options(argv)
      opt=Options.new
      parser=OptionParser.new do |o|
        o.banner = 'Usage: '+App.name+' {OPTIONS} [MODE]
  VERSION
    '+App.version+'

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
        App.panic parser, "\nFATAL: #{err}"
      end
      return opt
    end
  end
end
