class Stream < ActiveRecord::Base
  belongs_to :user

=begin
  searchable do
    text :title, :game, :description
    time :starttime
  end
=end

  def deleteWhenFinished
    self.destroy
  end
  handle_asynchronously :deleteWhenFinished, :run_at => Proc.new {|i| i.endtime }

  def tweetAtStart
    @user = User.find(self.user_id)

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER_KEY
      config.consumer_secret     = TWITTER_SECRET
      config.access_token        = @user.token
      config.access_token_secret = @user.secret
    end

    client.update(self.tweet)
  end
  handle_asynchronously :tweetAtStart, :run_at => Proc.new { |i| i.starttime }



end
