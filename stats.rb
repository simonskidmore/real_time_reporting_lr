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

  @unitsmarkedoff = res[0]["sum"].to_f.to_s
  @frunitsmarkedoff = res1[0]["sum"].to_f.to_s
  @dflunitsmarkedoff = res2[0]["sum"].to_f.to_s
  @tpunitsmarkedoff = res3[0]["sum"].to_f.to_s
  @dlgunitsmarkedoff = res4[0]["sum"].to_f.to_s

  @team = team

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
	res5 = conn.exec("
  	select sum(resource) as res
  	from resource
  	where team = '#{team}'
	")


	@available_resource = res5[0]["res"];

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

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
	res = conn.exec("
  	delete
  	from resource
  	where office = '#{office}'
	and team = '#{team}'
	")

	conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
	res = conn.exec("
  	insert
  	into resource
	(office, team, resource)
	VALUES
	('#{office}','#{team}','#{available_resource}'
	)
	")

  redirect '/stats/' + office + '/' + team

end
