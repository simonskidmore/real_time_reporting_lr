require 'pg'

conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
res = conn.exec("truncate rt_stats")

teams = Array.new();
teams << 'CT1'
teams << 'CT2'
teams << 'CT3'
teams << 'CT4'
teams << 'CT5'
teams << 'CT6'

applications = Array.new();
applications << 'DLG'
applications << 'FR'
applications << 'DFL'
applications << 'TP'



while true do

  for i in 0..(teams.length-1)
    application_type = applications[rand(0..3)]
    puts teams[i] + ' - ' + application_type
    res = conn.exec("insert into rt_stats (office, team, appn_type, hour, appn_count, units, modate) values ('PH', '#{teams[i]}', '#{application_type}', null, '1', '#{rand(0.1..0.8).round(1)}', current_date)")

  end

  sleep(5)

end
