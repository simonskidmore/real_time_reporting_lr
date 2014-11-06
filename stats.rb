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

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res1 = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and team = '#{team}'
	and appn_type = 'FR'
	")

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res2 = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and team = '#{team}'
	and appn_type = 'DFL'
	")

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res3 = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and team = '#{team}'
	and appn_type = 'TP'
	")

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res4 = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and team = '#{team}'
	and appn_type = 'DLG'
	")

  @unitsmarkedoff = res[0]["sum"]
  @frunitsmarkedoff = res1[0]["sum"]
  @dflunitsmarkedoff = res2[0]["sum"]
  @tpunitsmarkedoff = res3[0]["sum"]
  @dlgunitsmarkedoff = res4[0]["sum"]

  @team = team

  # get the resource for the team


  @available_resource = '10';

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

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res1 = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and office = '#{office}'
	and appn_type = 'FR'
	")

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res2 = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and office = '#{office}'
	and appn_type = 'DFL'
	")

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res3 = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and office = '#{office}'
	and appn_type = 'TP'
	")

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
  res4 = conn.exec("
  	select sum(units)
  	from rt_stats
  	where modate = current_date
	and office = '#{office}'
	and appn_type = 'DLG'
	")

  @unitsmarkedoff = res[0]["sum"]
  @frunitsmarkedoff = res1[0]["sum"]
  @dflunitsmarkedoff = res2[0]["sum"]
  @tpunitsmarkedoff = res3[0]["sum"]
  @dlgunitsmarkedoff = res4[0]["sum"]

  @team = office

  # get the resource for the whole office

  @available_resource = '10'


  @date = Time.now.strftime("%d/%m/%Y")
  erb :stats

end

post '/stats/:office/:team' do

  team = params[:team]
  office = params[:office]

  available_resource = params['available_resource']

  # Insert or Update the resource table

  redirect '/stats/' + office + '/' + team

end
