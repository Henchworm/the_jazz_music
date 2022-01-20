require "sinatra/base"
require "sinatra/activerecord"
require "pry"
require_relative "lib/gig"

class TheJazzMusicApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    "Hi Bitch"
  end

  get '/gigs' do
    @gigs = Gig.all
    erb :index
  end
  run! if app_file == $0
end