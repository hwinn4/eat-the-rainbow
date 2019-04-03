class Food < ApplicationRecord
  belongs_to :user
  validates_presence_of :date
  validates_presence_of :color

  enum color: %i[
    red
    orange
    yellow
    green
    blue
    purple
    black
    white
    tan
    brown
  ]

  def self.query_by_date(user_id, date)
    Food.where('date = ? AND user_id = ?', user_id, date)
  end
end