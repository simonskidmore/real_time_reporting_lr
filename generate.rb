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

while true do

  for i in 0..(teams.length-1)
    puts teams[i]
    res = conn.exec("insert into rt_stats (office, team, appn_type, hour, appn_count, units, modate) values ('PH', '#{teams[i]}', 'DLG', null, '1', '#{rand(0.1..0.8).round(2)}', current_date)")

  end
  
  for i in 0..(teams.length-1)
    puts teams[i]
    res = conn.exec("insert into rt_stats (office, team, appn_type, hour, appn_count, units, modate) values ('PH', '#{teams[i]}', 'FR', null, '1', '#{rand(0.1..0.8).round(2)}', current_date)")

  end
  
  for i in 0..(teams.length-1)
    puts teams[i]
    res = conn.exec("insert into rt_stats (office, team, appn_type, hour, appn_count, units, modate) values ('PH', '#{teams[i]}', 'DFL', null, '1', '#{rand(0.1..0.8).round(2)}', current_date)")

  end
  
  for i in 0..(teams.length-1)
    puts teams[i]
    res = conn.exec("insert into rt_stats (office, team, appn_type, hour, appn_count, units, modate) values ('PH', '#{teams[i]}', 'TP', null, '1', '#{rand(0.1..0.8).round(2)}', current_date)")

  end
  sleep(5)

end
