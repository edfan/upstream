class Stream < ActiveRecord::Base
  belongs_to :user

  def deleteWhenFinished
    self.destroy
  end
  handle_asynchronously :deleteWhenFinished, :run_at => Proc.new {|i| i.endtime }

end
