require 'sinatra'
require 'erb'
require 'pg'
set :bind, '0.0.0.0'

get '/stats/:office/:team' do

  team = params[:team]

conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and team = '#{team}'
	")

  @unitsmarkedoff = res[0]["sum"]

  @team = team
  
   @date = Time.now.strftime("%d/%m/%Y")

  erb :stats
 
 end
  
  get '/stats/:office' do

  office = params[:office]

conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and office = '#{office}'
	")

  @unitsmarkedoff = res[0]["sum"]

  @team = office

  @date = Time.now.strftime("%d/%m/%Y")
  erb :stats
  
end
