require 'bundler'
Bundler.require
require 'active_support/core_ext'



configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/the-jazz-music')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )

APP_ROOT = File.expand_path("..", __dir__)
# require the controller(s)
Dir.glob(File.join(APP_ROOT, 'app', 'controllers', '*.rb')).each { |file| require file }
# require the model(s)
Dir.glob(File.join(APP_ROOT, 'app', 'models', '*.rb')).each { |file| require file }
# require database configurations
require File.join(APP_ROOT, 'config', 'database')
# configure SinatraPractice settings
class TheJazzMusicApp < Sinatra::Base
 set :method_override, true
 set :root, APP_ROOT
 set :views, File.join(APP_ROOT, "app", "views")
 set :public_folder, File.join(APP_ROOT, "app", "public")
end

