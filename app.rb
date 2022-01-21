require "sinatra/base"
require 'activerecord
require "sinatra/activerecord"
require 'active_support/core_ext'


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

  get '/admin/gigs/new' do
    erb :admin_new
  end

  post '/create' do
    Gig.create!(
      date: DateTime.strptime(params[:date], '%m/%d/%Y'),
      band_name: params[:band_name],
      music_link: params[:music_link]
    )
    redirect '/gigs'
  end

  run! if app_file == $0
end