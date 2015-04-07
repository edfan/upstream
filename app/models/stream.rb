class Stream < ActiveRecord::Base
  belongs_to :user

  searchable do
    text :title, :game, :description
    time :starttime
  end

  def deleteWhenFinished
    self.destroy
  end
  handle_asynchronously :deleteWhenFinished, :run_at => Proc.new {|i| i.endtime }

end
