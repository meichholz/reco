# @alltodos

# @example
#   module Emigma
#     class Foo
#       load_helpers
#       # .. off we go ..
#     end
#   end
module Reco

  NAME = "reco"

  # just abstract away these application specific namespace(s)
  def include_helpers
    include Reco::Helper
  end

  # config is hosted right here
  # @return [Class<Emigma::Helper>]
  def config
    Reco::Helper
  end

  def not_implemented_yet
    raise "method is not implemented yet"
  end

  # @todo
  #   * class and instance sub modules
  #   * include hook
  #   * usability of helpers from class level
  module Helper
    Name = File.basename(File.dirname(__FILE__))
    Version = VERSION

    DebugMasks = {
      wip: 0x0001,
      all: 0xFFFF,
    }

    # um... seems as if we instantiate the module with some state and instance
    # logic here...

    @verbose = true
    @debugmask = 0xFFFF

    class << self
      attr_accessor :verbose
      attr_accessor :debugmask
      attr_accessor :mode
      attr_accessor :params

      def debugging?(what)
        mask = Helper::DebugMasks[what]
        return false if mask.nil? 
        debugmask & mask == mask
      end
    end

    # some utility functions go here...

    # put some notification onto the console
    # @param [Array] arg Whatever can be joined :-)
    # @return [self]
    def notify(*arg)
      puts "[#{_classname}] "+arg.join("\n") if Helper.verbose
      return self
    end

    # put debug notification onto the console.
    # @note only works for class instances!
    # @param [Symbol] what the symbolic logging level needed (:wip, :http)
    # @param [Array] arg Whatever can be joined :-)
    # @return [self]
    def debuginfo(what, *arg)
      STDERR.puts "[#{_classname}][DEBUG] "+arg.join("\n") if Helper.debugging?(what)
      return self
    end

    def on_debug(what)
      if Helper.debugging?(what)
        yield
      end
    end

    # put a last warning onto the console and exit.
    # @param [Array] arg Whatever can be joined :-)
    # @return [void]
    def panic(*arg)
      puts "FATAL: "+arg.join("\n")+" (#{NAME} aborted by #{_classname}])"
      exit 1
    end
    class << self
      attr_accessor :configuration, :logger

      def name
        Name
      end

      def version
        Version
      end

      def verbalize(str)
        $stderr.puts(str) if self.configuration.verbose
      end

    end
    
    private
    # @todo: undry, brittle. Should get into a class instance extension
    # @return [String] downcased class name without outer module
    def _classname
      return self.class.to_s.gsub(/^Reco::/,"").downcase
    end
  end
end unless defined? Reco::NAME

