require 'rails_helper'

RSpec.describe Food do
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:color) }
end