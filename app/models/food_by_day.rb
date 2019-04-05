class FoodByDay < ActiveRecord::Base
  self.primary_key = :id
  belongs_to :user

  include ColorEnum

  def self.search(user_id, date)
    where("date(date) = ? AND user_id = #{user_id}", date)
  end

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end
end