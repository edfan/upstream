class WeeklyStream < ActiveRecord::Base

  belongs_to :user

  def weeklyCreate
    @stream = Stream.new
    @stream.user = self.user
    @stream.title = self.title
    @stream.description = self.description
    @stream.game = self.game
    @stream.tweet = self.tweet
    @stream.starttime = Chronic.parse('next ' + self.day + ' ' + self.starttime.to_s(:time))
    @stream.endtime = Chronic.parse('next ' + self.day + ' ' + self.endtime.to_s(:time))
    @stream.save!
  end

end
