require 'optparse'
require 'forwardable'
# require 'fileutils'
require 'time'
require 'tempfile'

@debug_autoload = ENV['DEBUG_AUTOLOAD']

def load_modules(*preload_modules)
  STDERR.printf "==> loading modules: " if @debug_autoload
  loadpath = File.join(File.dirname(__FILE__), File.basename(__FILE__, '.rb'), '') # include empty slash!
  basemodules = preload_modules.collect {|f| loadpath+f.to_s+'.rb'}
  allmodules = Dir[loadpath + '**.rb']
  (basemodules+(allmodules-basemodules)).each do |file|
    STDERR.printf "%s, ", File.basename(file,'.rb') if @debug_autoload
    load file
  end
  STDERR.puts "  done." if @debug_autoload
end

load_modules :version, :helper
include Reco # @todo do this in helper


