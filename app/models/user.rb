class User < ActiveRecord::Base
  serialize :follows

  has_many :streams

  searchable do
    text :name
  end
end
