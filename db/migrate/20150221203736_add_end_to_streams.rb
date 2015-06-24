class AddEndToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :end, :datetime
  end
end
