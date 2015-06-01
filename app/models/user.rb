class User < ActiveRecord::Base
  serialize :follows

  has_many :streams
  has_many :weekly_streams

=begin
  searchable do
    text :name
  end
=end  

end
