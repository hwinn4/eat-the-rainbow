class DailyFoodLog < ActiveRecord::Base
  self.primary_key = :id
  belongs_to :user

  include ColorEnum



  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end
end