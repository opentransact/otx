require 'sinatra/base'
require 'active_record'
require 'active_support/all'
require 'oauth'
require 'oauth/consumer'
require 'oauth/token'
require 'opentransact'

Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each { |f| require f }

class Otx < Sinatra::Base
  ENV["RACK_ENV"] ||= "development"

  configure do
    enable :method_override
    enable :sessions, :logging
    set :haml, {:format => :html5 }
    set :root, File.dirname(__FILE__)
    set :public, Proc.new { File.join(root, "public") }
    dbconfig = YAML.load( File.read( File.join(root, 'config', 'database.yml')))
    ActiveRecord::Base.establish_connection dbconfig[ENV["RACK_ENV"]]
  end

  configure :production do
    disable :logging
  end

  configure :development do
    enable :logging
    enable :show_exceptions
  end

  configure :test do
    enable :raise_errors
    disable :logging
    disable :reload_templates
  end

  helpers do
  end

  get '/' do
    haml :index
  end

  get '/offers' do
    @offers = Offer.all
    haml :"/offers/index"
  end

  get '/offers/new' do
    @offer = Offer.new :offered_url => params[:offered_url],
      :offered_amount => params[:offered_amount],
      :wanted_url => params[:wanted_url], :wanted_amount => params[:wanted_amount],
      :expires => params[:expires]
    haml :"/offers/new"
  end

  get '/offers/:id' do |id|
    @offer = Offer.find id
    haml :"/offers/show"
  end

  post '/offers' do
    @offer = Offer.new :offered_url => params[:offered_url],
      :offered_amount => params[:offered_amount],
      :wanted_url => params[:wanted_url], :wanted_amount => params[:wanted_amount],
    :expires => params[:expires]

    if @offer.save
      redirect "/offers/#{@offer.id}"
    else
      haml :"/offers/new"
    end
  end
end
