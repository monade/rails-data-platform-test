require 'rails_helper'

RSpec.describe DataSource, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:data_source)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:data_source, name: nil)).to be_invalid
  end

  it "has valid associations" do
    expect(FactoryBot.build(:data_source).kind).to be_a(DataSourceKind)
    expect(FactoryBot.build(:data_source).district).to be_a(District)
  end
end
