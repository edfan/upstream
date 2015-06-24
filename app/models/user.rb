class User < ActiveRecord::Base
  serialize :follows

  has_many :streams
  has_many :weekly_streams

  searchable do
    text :name
  end
end
