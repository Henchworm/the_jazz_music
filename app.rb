require 'bundler'
Bundler.require
require 'pry'

require 'sinatra/base'
require "sinatra/activerecord"
require_relative 'lib/gig'

class TheJazzMusicApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    "Hi Bitch"
  end

  get '/admin/gigs' do
    @gigs = Gig.all
    erb :admin_index
  end

  get '/admin/gigs/:id' do
    @gig = Gig.find(params[:id])
    erb :admin_show
  end



  get '/admin/gigs/new' do
    erb :admin_new
  end

  post '/admin/gigs/create' do
    Gig.create!(
      date: DateTime.strptime(params[:date], '%m/%d/%Y'),
      band_name: params[:band_name],
      music_link: params[:music_link]
    )
    redirect '/admin/gigs'
  end

  run! if app_file == $0
end