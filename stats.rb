require 'sinatra'
require 'erb'
require 'pg'
set :bind, '0.0.0.0'

get '/stats/:team' do

  team = params[:team]

conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
res = conn.exec("select * from rt_stats")


  @team = team
  @unitsmarkedoff = '99.9'

  erb :stats
end
