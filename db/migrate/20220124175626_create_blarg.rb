class CreateBlarg < ActiveRecord::Migration[6.0]
  def change
    create_table :blargs do |t|
      t.string :title
      t.string :subject
      t.text :text
      t.timestamps
    end
  end
end
