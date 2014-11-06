require 'pg'

conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
res = conn.exec("select * from rt_stats")

teams = Array.new();
teams << 'CT1'
teams << 'CT2'
teams << 'CT3'
teams << 'CT4'
teams << 'CT5'

while true do

  for i in 0..(teams.length-1)
    puts teams[i]
    res = conn.exec("insert into rt_stats (office, team, appn_type, hour, appn_count, units, modate) values ('PH', '#{teams[i]}', 'DLG', null, 5, 5, current_date)")

  end
  sleep(5)

end
