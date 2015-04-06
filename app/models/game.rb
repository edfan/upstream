class Game < ActiveRecord::Base

  scope :finder, lambda { |q| where("name ILIKE :q", q: "%#{q}%") }

  def as_json(options)
    { id: id, text: name }
  end

end
