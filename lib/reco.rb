require 'optparse'
require 'forwardable'
# require 'fileutils'
require 'time'

@debug_autoload = ENV['DEBUG_AUTOLOAD']

def load_modules
  STDERR.printf "==> loading modules: " if @debug_autoload
  loadpath = File.join(File.dirname(__FILE__), File.basename(__FILE__, '.rb'), '') # include empty slash!
  basemodules = %w( version ).collect {|f| loadpath+f+'.rb'}
  allmodules = Dir[loadpath + '**.rb']
  (basemodules+(allmodules-basemodules)).each do |file|
    STDERR.printf "%s, ", File.basename(file,'.rb') if @debug_autoload
    load file
  end
  STDERR.puts "  done." if @debug_autoload
end

load_modules

