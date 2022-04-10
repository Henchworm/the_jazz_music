database_name = "the-jazz-music-#{TheJazzMusicApp.environment}"
db = URI.parse(ENV['DATABASE_URL'] || "postgres://localhost#{datbase_name}")

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: "db/#{database_name}"
)
