require 'optparse'
require 'forwardable'
require 'ostruct'
# require 'fileutils'
require 'time'
require 'tempfile'

@debug_autoload = ENV['DEBUG_AUTOLOAD']

def load_modules(*preload_modules)
  STDERR.printf "==> loading modules: " if @debug_autoload
  loadpath = File.join(File.dirname(__FILE__), File.basename(__FILE__, '.rb'), '') # include empty slash!
  basemodules = preload_modules.collect do |f|
    file = loadpath+f.to_s+'.rb'
    STDERR.printf("%s, ", f.to_s) if @debug_autoload
    load file
    file
  end
  include Reco
  allmodules = Dir[loadpath + '**.rb'] - basemodules
  allmodules.each do |file|
    STDERR.printf "%s, ", File.basename(file,'.rb') if @debug_autoload
    load file
  end
  STDERR.puts "  done." if @debug_autoload
end

load_modules :version, :helper


