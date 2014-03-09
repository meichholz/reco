module Reco
  class Helper
    Name = File.basename(File.dirname(__FILE__))
    Version = VERSION
    @configuration = nil
    @logger = nil

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

      def panic(*args)
        $stderr.puts *args
        $stderr.puts "bailing out..."
        exit 1
      end
    end
  end
end

