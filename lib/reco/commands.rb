module Reco

  class App # @think probably the registry should be a class entity of it's own
    @command_procs = { }
    @command_short_desc = { }

    class << self

      def command_proc(command)
        @command_procs[command]
      end

      def register_command(command, short_desc, &block)
        @command_procs[command] = block
        @command_short_desc[command] = short_desc
      end
    
    end

    self.register_command :wip, "DEBUG: Generic test command" do
      puts "running WIP command"
    end

  end
end
