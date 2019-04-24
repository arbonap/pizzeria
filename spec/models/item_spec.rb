require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }
end
