class AddTwitterTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :secret, :string
    add_column :streams, :tweet, :text
    add_column :weekly_streams, :tweet, :text
  end
end
