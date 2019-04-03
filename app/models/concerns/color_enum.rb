module ColorEnum
  extend ActiveSupport::Concern
  included do
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
  end
end