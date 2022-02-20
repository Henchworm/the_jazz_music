require 'bundler'
Bundler.require

require 'sinatra/base'
require "sinatra/activerecord"
require_relative 'models/gig'
require_relative 'models/blarg'

class TheJazzMusicApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    erb :"public/welcome"
  end

  get '/music' do
    erb :"public/music"
  end

  get '/bandcamp' do
    redirect to "https://chrishewitt.bandcamp.com"
  end

  get '/github' do
    redirect to "https://github.com/Henchworm"
  end

  get '/youtube' do
    redirect to "https://www.youtube.com/channel/UCMsFCUejwHYwPpKttz9H31g"
  end

  get '/blargs' do
    @blargs = Blarg.all
    erb :"public/blarg_index"
  end

  get '/gigs' do
    @gigs = Gig.all
    erb :"public/gig_index"
  end

  get '/gigs/:id/music_link' do
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
      venue:      params[:venue],
      band_name:  params[:band_name],
      deets:      params[:deets],
      music_link: params[:music_link]
    )
    redirect '/admin/gigs'
  end

  get '/admin/blargs' do
    @blargs = Blarg.all
    erb :"/admin/admin_blargs"
  end

  get '/admin/blargs/new' do
    erb :"/admin/blarg_new"
  end

  post '/admin/blargs/create' do
    Blarg.create!(
      title:    params[:title],
      text:     params[:text],
      subject:  params[:subject]
    )
    redirect '/admin/blargs'
  end
  run! if app_file == $0
end