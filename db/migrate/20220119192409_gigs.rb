class Gigs < ActiveRecord::Migration[7.0]
  def change
    create_table :gigs do |t|
     t.string :date
     t.string :band_name
     t.string :music_link
     t.timestamps
   end
  end
end
