require 'sinatra'
require 'pry'
require 'csv'


helpers do
  def parse_roster
    players = []

    CSV.foreach('roster.csv',headers:true) do |row|
      players << {first_name: row['first_name'],
                  last_name: row['last_name'],
                  position: row['position'],
                  team: row['team']
                }
    end

    players
  end
end

get '/teams/:team' do
  @team = params[:team]
  @players = parse_roster
  @team_name_capitalized = @team.split(" ").each { |name| name.capitalize! }.join(" ")
  erb :teams
end

get '/positions/:position' do
  @position = params[:position]
  @players = parse_roster
  @position_cap = @position.split(" ").each { |name| name.capitalize! }.join(" ")
  erb :positions
end

