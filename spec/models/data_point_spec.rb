require 'rails_helper'

RSpec.describe DataPoint, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:data_point)).to be_valid
  end

  it "is invalid without a value" do
    expect(FactoryBot.build(:data_point, value: nil)).to be_invalid
  end

  it "has valid associations" do
    expect(FactoryBot.build(:data_point).data_source).to be_a(DataSource)
    expect(FactoryBot.build(:data_point).owner).to be_a(Owner)
  end
end
