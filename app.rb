require 'bundler'
Bundler.require

require "pry"
require 'sinatra/base'
require "sinatra/activerecord"
require_relative 'lib/gig'

class TheJazzMusicApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    erb :welcome
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

  get '/admin/gigs/:id/edit' do
    @gig = Gig.find(params[:id])
    erb :"/admin/admin_edit"
  end

  post '/admin/gigs/:id/edit' do
    gig = Gig.find(params[:id])
    gig.update(
      date: DateTime.strptime(params[:date], '%m/%d/%Y'),
      venue: params[:venue],
      band_name: params[:band_name],
      deets: params[:deets],
      music_link: params[:music_link]
    )
    redirect '/admin/gigs'
  end

  post '/admin/gigs/:id/destroy' do
    Gig.find(params[:id]).destroy
    redirect to "/admin/gigs"
  end

  post '/admin/gigs/create' do
    Gig.create!(
      date: DateTime.strptime(params[:date], '%m/%d/%Y'),
      venue: params[:venue],
      band_name: params[:band_name],
      deets: params[:deets],
      music_link: params[:music_link]
    )
    redirect '/admin/gigs'
  end

  run! if app_file == $0
end