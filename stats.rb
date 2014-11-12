require 'sinatra'
require 'erb'
require 'pg'
set :bind, '0.0.0.0'

get '/stats/:office/:team' do

  team = params[:team]
  office = params[:office]

  @unitsmarkedoff = getTeamStata(office, team)[0]["sum"].to_f.to_s
  @frunitsmarkedoff = getTeamStata(office, team, 'FR')[0]["sum"].to_f.to_s
  @dflunitsmarkedoff = getTeamStata(office, team, 'DFL')[0]["sum"].to_f.to_s
  @tpunitsmarkedoff = getTeamStata(office, team, 'TP')[0]["sum"].to_f.to_s
  @dlgunitsmarkedoff = getTeamStata(office, team, 'DLG')[0]["sum"].to_f.to_s

  @team = team

  @available_resource = getAvailableResource(office, team)[0]["sum"].to_f.to_s

  @daily_target = @available_resource.to_f * 11;

  if (@unitsmarkedoff.to_f > @daily_target.to_f) then
    @greenbackground = ' style="background:#00CC99"'
  end

	@date = Time.now.strftime("%d/%m/%Y")

  erb :stats

end

get '/stats/:office' do

  office = params[:office]

  @unitsmarkedoff = getTeamStata(office, nil)[0]["sum"].to_f.to_s
  @frunitsmarkedoff = getTeamStata(office, nil, 'FR')[0]["sum"].to_f.to_s
  @dflunitsmarkedoff = getTeamStata(office, nil, 'DFL')[0]["sum"].to_f.to_s
  @tpunitsmarkedoff = getTeamStata(office, nil, 'TP')[0]["sum"].to_f.to_s
  @dlgunitsmarkedoff = getTeamStata(office, nil, 'DLG')[0]["sum"].to_f.to_s

  @team = office

  @available_resource = getAvailableResource(office)[0]["sum"].to_f.to_s
  @daily_target = @available_resource.to_f * 11;

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

def getTeamStata(office, team = nil, app_type = nil)

  conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")

  sql = "select sum(units)
    from rt_stats
    where modate = current_date
    and office = '#{office}'"

  if (!team.nil?) then
    sql = sql + " and team = '#{team}'"
  end

  if (!app_type.nil?) then
    sql = sql + " and appn_type = '#{app_type}'"
  end

  res = conn.exec(sql)
  conn.close

  return res

end


def getAvailableResource(office, team = nil)

  conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")

  sql = "select sum(resource)
    from resource
    where office = '#{office}'"

  if (!team.nil?) then
    sql = sql + " and team = '#{team}'"
  end

  res = conn.exec(sql)

  conn.close

  return res

end
