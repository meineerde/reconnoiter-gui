require 'sinatra'
require 'json'

%w(lib helpers).each do |dir|
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/#{dir}")
  Dir.glob("#{File.dirname(__FILE__)}/#{dir}/*.rb") { |lib| require File.basename(lib, '.*') }
end

helpers Sinatra::Partials

set :haml, {:ugly => true, :format => :xhtml}

get '/' do
  # @domain = DB.realtime_config('document.domain')
  @domain = "localhost"
  # @hostname = DB.realtime_config('hostname')
  @hostname = "localhost"
  
  haml :index, {:ugly => true}
end

get "/json/worksheet/search" do
  { :query => "",
    :limit => params[:l].to_s,
    :offset => params[:o].to_s,
    :results => []
  }.to_json
end

get "/json/*" do
  [].to_json
end