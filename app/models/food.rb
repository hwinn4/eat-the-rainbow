class Food < ApplicationRecord
  belongs_to :user
  validates_presence_of :date
  validates_presence_of :color

  before_save :convert_color_to_enum

  include ColorEnum

  private

  def convert_color_to_enum
    self.color = Food.colors[self.color]
  end
end