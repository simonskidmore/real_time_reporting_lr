ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'


require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start

require_relative 'stats.rb'  # <-- your sinatra app


describe 'Real Time stats' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "Page Valid for team" do
    get '/stats/PH/CT5'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('CaseWorker Real Time Reporting')
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
