class User < ActiveRecord::Base
  serialize :follows

  has_many :streams
end
