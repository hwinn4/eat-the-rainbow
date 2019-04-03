class DailyFoodLog < ActiveRecord::Base
  self.primary_key = :id
  belongs_to :user

  # TODO: What do to about this duplication?
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

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end
end