class CreateWeeklyStreams < ActiveRecord::Migration
  def change
    create_table :weekly_streams do |t|
      t.string :title
      t.string :game
      t.text :description
      t.time :starttime
      t.time :endtime
      t.text :day

      t.timestamps
    end
  end
end
