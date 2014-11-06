require 'sinatra'
require 'erb'
require 'pg'
set :bind, '0.0.0.0'

get '/stats/:team' do

  team = params[:team]

conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
res = conn.exec("
	select sum(units)
	from rt_stats
	where modate = current_date")

	res.each do |row|
	@unitsmarkedoff = row["units"]
	end

  @team = team

  erb :stats
end
