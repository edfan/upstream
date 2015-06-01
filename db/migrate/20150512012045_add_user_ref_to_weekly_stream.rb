class AddUserRefToWeeklyStream < ActiveRecord::Migration
  def change
    add_reference :weekly_streams, :user, index: true
  end
end
