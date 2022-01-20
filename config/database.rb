require "sinatra/activerecord"

database_name = "the-jazz-music-#{TheJazzMusicApp.environment}"
db = URI.parse(ENV['DATABASE_URL'] || "postgres://localhost#{datbase_name}")

ActiveRecord::Base.establish_connection(
 :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
 :host => db.host,
 :port => db.port,
 :username => db.user,
 :password => db.password,
 :database => "#{database_name}",
 :encoding => 'utf8'
)