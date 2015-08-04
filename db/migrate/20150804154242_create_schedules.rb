class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :interval, null: false
      t.time :time, null: false
    end
  end
end
