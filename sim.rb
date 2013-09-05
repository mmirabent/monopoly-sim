$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib") unless $LOAD_PATH.include? "#{File.dirname(__FILE__)}/lib"

require 'game'
require 'logging'
include Logging

g = Game.new
for i in 0..100
  g.turn
end