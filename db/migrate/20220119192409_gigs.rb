class Gigs < ActiveRecord::Migration[6.0]
  def change
    create_table :gigs do |t|
     t.datetime :date
     t.string :band_name
     t.string :music_link
     t.timestamps
   end
  end
end
