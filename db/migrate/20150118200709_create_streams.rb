class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :title
      t.string :game
      t.text :description
      t.datetime :start
      t.references :user, index: true

      t.timestamps
    end
  end
end
