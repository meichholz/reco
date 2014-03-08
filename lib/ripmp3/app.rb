module Ripmp3
  class App
    Name = 'ripmp3'
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
        $stderr.puts(str) if App.configuration.verbose
      end

      def panic(*args)
        $stderr.puts *args
        $stderr.puts "bailing out..."
        exit 1
      end
    end
  end
end
