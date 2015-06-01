require 'clockwork'
module Clockwork

  every(1.week, 'create', :at => 'Monday 00:00') {
  WeeklyStreams.all.each do |stream|
    stream.weeklyCreate
  end
  }
end
