require 'bundler'
Bundler.require

require 'sinatra/base'
require "sinatra/activerecord"
require_relative 'lib/gig'
require "pry"

class TheJazzMusicApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    "Hi Bitch"
  end

  get '/gigs' do
    @gigs = Gig.all
    erb :index
  end

  get "/gigs/:id/music_link" do
    gig = Gig.find(params[:id])
    redirect to gig.music_link
  end

  get '/admin/gigs' do
    @gigs = Gig.all
    erb :"admin/admin_index"
  end

  get '/admin/gigs/new' do
    erb :"admin/admin_new"
  end

  get '/admin/gigs/:id' do
    @gig = Gig.find(params[:id])
    erb :"/admin/admin_show"
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