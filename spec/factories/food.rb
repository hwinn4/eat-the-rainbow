FactoryBot.define do
  factory :food do
    color { 0 }
    date { Date.today }
    user
  end
end