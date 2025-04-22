require 'rails_helper'

RSpec.describe Region, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:region)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:region, name: nil)).to be_invalid
  end
end
