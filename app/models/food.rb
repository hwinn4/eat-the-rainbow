class Food < ApplicationRecord
  belongs_to :user
  validates_presence_of :date
  validates_presence_of :color

  before_save :convert_color_to_enum

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

  def self.find_daily_log(user_id, date)
    # Food.group(:user_id, :date, :color).having('date = ? AND user_id = ?', user_id, date)
    # Food.where('date = ? AND user_id = ?', user_id, date).group(:color)
    # TODO: implement a sql view to count colors by day and generate a log view?
    Food.select(:date, :color, :user_id).group(:user_id, :date, :color).having('date = ? AND user_id = ?', user_id, date)
  end

  private

  def convert_color_to_enum
    self.color = Food.colors[self.color]
  end
end