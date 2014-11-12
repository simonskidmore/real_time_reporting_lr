ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'

require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start

require_relative 'stats.rb'  # <-- your sinatra app

class PGStub
  def exec(sql)
    if (sql.match(/from resource/i))
      if (sql.match(/CT1/i))
        res = Hash.new()
        res[0] = Hash.new()
        res[0]['sum'] = '0'
      else
        res = Hash.new()
        res[0] = Hash.new()
        res[0]['sum'] = '5'
      end
    else
      res = Hash.new()
      res[0] = Hash.new()
      res[0]['sum'] = '7'
    end
    return res
  end

  def close()

  end
end


class PG::Connection
  def self.connect(*args)
    stub = PGStub.new()
    return stub
  end
end

# Try mocha? to stub
describe 'Real Time stats' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "Page Valid for team" do
    get '/stats/PH/CT5'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('CaseWorker Real Time Reporting')
    expect(last_response.body).to include('Resource:</b> 5')
    expect(last_response.body).to include('TP</b> <br />7')
  end

  it "Page Valid for office" do
    get '/stats/PH'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('CaseWorker Real Time Reporting')
  end

  it "Page Valid for office" do
    post '/stats/PH/CT5', { available_resource: '5' }
    expect(last_response.status).to eq(302)
  end

  it "Page Valid for team" do
    get '/stats/PH/CT1'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('CaseWorker Real Time Reporting')
  end

end
