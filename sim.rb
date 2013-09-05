$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib") unless $LOAD_PATH.include? "#{File.dirname(__FILE__)}/lib"

require 'game'
require 'logging'
require 'CSV'

g = Game.new
for i in 0..100
  g.turn
end

CSV.open("test.csv", "wb") do |csv|
  csv << ["Name", "Hits"]
  
  g.board.spaces.each do |space|
    csv << [space.name, space.hit_count]
  end
  
  csv << ["Total hits",100]
end
