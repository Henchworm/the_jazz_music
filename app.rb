require 'bundler'
Bundler.require

require 'sinatra/base'
require "sinatra/activerecord"
require_relative 'models/gig'
require_relative 'models/blarg'
require_relative 'models/admin'



class TheJazzMusicApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions


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
    @emojis = ["🤖 ", "👽", " ⚡️",  "✨", " 🦑 ", "🦴"]
    erb :"public/gig_index"
  end

  get '/gigs/:id/music_link' do
    gig = Gig.find(params[:id])
    redirect to gig.music_link
  end

  #ADMIN

  get '/admin/login' do
    erb :"admin/admin_login"
  end

  post '/admin/login' do
    admin = Admin.find_by(username: params[:username])
    if admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect 'admin/dashboard'
    else
      redirect 'admin/login'
    end
  end

  get '/admin/dashboard' do
    admin = Admin.find(session[:admin_id]) if session[:admin_id]
    if admin.present?
      erb :"admin/admin_dashboard"
    else
      redirect 'admin/login'
    end
  end

  get '/admin/gigs' do
    admin = Admin.find(session[:admin_id]) if session[:admin_id]
    if admin.present?
      @gigs = Gig.all
      erb :"admin/admin_index"
    else
      erb :"admin/admin_login"
    end
  end

  get '/admin/gigs/new' do
    admin = Admin.find(session[:admin_id]) if session[:admin_id]
    if admin.present?
      erb :"admin/admin_new"
    else
      erb :"admin/admin_login"
    end
  end

  get '/admin/gigs/:id' do
    admin = Admin.find(session[:admin_id]) if session[:admin_id]
    if admin.present?
      @gig = Gig.find(params[:id])
      erb :"/admin/admin_show"
    else
      erb :"admin/admin_login"
    end
  end

  get '/admin/gigs/:id/edit' do
    admin = Admin.find(session[:admin_id]) if session[:admin_id]
    if admin.present?
      @gig = Gig.find(params[:id])
      erb :"/admin/admin_edit"
    else
      erb :"admin/admin_login"
    end
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
    admin = Admin.find(session[:admin_id]) if session[:admin_id]
    if admin.present?
      @blargs = Blarg.all
      erb :"/admin/admin_blargs"
    else
      erb :"admin/admin_login"
    end
  end

  get '/admin/blargs/new' do
    admin = Admin.find(session[:admin_id]) if session[:admin_id]
    if admin.present?
      erb :"/admin/blarg_new"
    else
      erb :"admin/admin_login"
    end
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