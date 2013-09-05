require 'logger'

module Logging
  def log
    Logging.log
  end
  
  def self.log
    @log ||= Logger.new(File.join(File.dirname(__FILE__),"..","log","debug.log"))
  end
end