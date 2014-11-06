require 'sinatra'
require 'erb'
require 'pg'
set :bind, '0.0.0.0'

get '/stats' do

conn = PGconn.connect("localhost", "5432", "", "", "postgres", "postgres", "admin")
res = conn.exec("select * from rt_stats")

  erb :stats
end
