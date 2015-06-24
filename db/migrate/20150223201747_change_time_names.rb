class ChangeTimeNames < ActiveRecord::Migration
  def change
    remove_column :streams, :start, :datetime
    remove_column :streams, :end, :datetime
    add_column :streams, :starttime, :datetime
    add_column :streams, :endtime, :datetime
  end
end
