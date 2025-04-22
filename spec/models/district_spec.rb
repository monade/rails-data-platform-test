require 'rails_helper'

RSpec.describe District, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:district)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:district, name: nil)).to be_invalid
  end

  it "is invalid without a region" do
    expect(FactoryBot.build(:district, region: nil)).to be_invalid
  end

  it "has valid associations" do
    expect(FactoryBot.build(:district).region).to be_a(Region)
  end
end
