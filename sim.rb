$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib") unless $LOAD_PATH.include? "#{File.dirname(__FILE__)}/lib"

require 'game'
require 'logging'
require 'CSV'

Run1 = [100,200,500,1000,2000,5000]

Run1.each do |turns|
  g = Game.new
  for i in 0..turns
    g.turn
  end
  CSV.open("monopoly-#{turns}-turns.csv", "wb") do |csv|
    csv << ["Name", "Hits"]
  
    g.board.spaces.each do |space|
      csv << [space.name, space.hit_count]
    end
  
    csv << ["Total hits",turns]
  end
end
