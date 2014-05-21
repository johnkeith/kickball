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

  # def get_all_team_names
  #   teams = []
  #   players = parse_roster
  #   players.each do |players|
  #     teams << players[:team] unless teams.include?(players[:team])
  #   end
  #   binding.pry
  #   teams
  # end
end

get '/' do
  redirect '/teams'
end

get '/teams' do
  @players = parse_roster
  @teams = []
  @positions = []

  parse_roster.each do |player|
    @teams << player[:team] unless @teams.include?(player[:team])
    @positions << player[:position] unless @positions.include?(player[:position])
  end

  erb :'teams/index'
end

get '/teams/:team' do
  @team = params[:team]
  @players = parse_roster.find_all { |player| player[:team] == @team }
  @team_name_capitalized = @team.split(" ").each { |name| name.capitalize! }.join(" ")
  erb :'teams/show'

end

get '/positions/:position' do
  @position = params[:position]
  @players = parse_roster.find_all { |player| player[:position] == @position }
  @position_cap = @position.split(" ").each { |name| name.capitalize! }.join(" ")
  
  erb :'positions/show'
end

