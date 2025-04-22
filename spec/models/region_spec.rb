require 'rails_helper'

RSpec.describe Region, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:region)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:region, name: nil)).to be_invalid
  end

  it "can be found by district" do
    region = FactoryBot.create(:region)
    district = FactoryBot.create(:district, region: region)

    expect(Region.with_district(district)).to eq(region)
  end

  it "can be found by district name" do
    region = FactoryBot.create(:region)
    FactoryBot.create(:district, name: "Brescia", region: region)

    expect(Region.with_district("Brescia")).to eq(region)
  end
end
