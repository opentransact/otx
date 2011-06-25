require 'sinatra/base'
require 'active_record'
require 'active_support/all'
require 'oauth'
require 'oauth/consumer'
require 'oauth/token'
require 'opentransact'

class Otx < Sinatra::Base
  ENV["RACK_ENV"] ||= "development"

  enable :sessions, :logging
  set :haml, {:format => :html5 }
  set :root, File.dirname(__FILE__)
  set :public, Proc.new { File.join(root, "public") }

  configure do
    dbconfig = YAML.load( File.read( File.join(root, 'config', 'database.yml')))
    ActiveRecord::Base.establish_connection dbconfig[ENV["RACK_ENV"]]
  end

  helpers do
  end

  get '/' do
    haml :index
  end

end
