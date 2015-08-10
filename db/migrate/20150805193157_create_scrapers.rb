class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name, null: false
      t.text :hosts_files, null: false

      t.timestamps
    end
  end
end
