class Food < ApplicationRecord
  belongs_to :user
  validates_presence_of :date
  validates_presence_of :color
end