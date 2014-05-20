require 'sinatra'
require 'pry'
require 'csv'


helpers do
  def parse_roster
    players = []

    CSV.foreach('roster.csv',headers:true) do |row|
      players << {first_name: row['first_name'], last_name: row['last_name'], position: row['position'], team: row['team']}
    end

    players
  end
end

get '/' do
  erb :index
end
