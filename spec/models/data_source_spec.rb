require 'rails_helper'

RSpec.describe DataSource, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:data_source)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:data_source, name: nil)).to be_invalid
  end

  it "is valid without a district" do
    expect(FactoryBot.build(:data_source, district: nil)).to be_valid
  end

  it "is invalid without a data source kind" do
    expect(FactoryBot.build(:data_source, data_source_kind: nil)).to be_invalid
  end

  it "has valid associations" do
    expect(FactoryBot.build(:data_source).kind).to be_a(DataSourceKind)
    expect(FactoryBot.build(:data_source).district).to be_a(District)
  end

  it "can be filtered by data point presence" do
    data_source_with_data_points = FactoryBot.create(:data_source)
    FactoryBot.create(:data_point, data_source: data_source_with_data_points)
    data_source_without_data_points = FactoryBot.create(:data_source)

    with = DataSource.with_data_points

    expect(with).to include(data_source_with_data_points)
    expect(with).not_to include(data_source_without_data_points)
  end

  it "can be filtered by data point absence" do
    data_source_with_data_points = FactoryBot.create(:data_source)
    FactoryBot.create(:data_point, data_source: data_source_with_data_points)
    data_source_without_data_points = FactoryBot.create(:data_source)

    without = DataSource.without_data_points

    expect(without).to include(data_source_without_data_points)
    expect(without).not_to include(data_source_with_data_points)
  end
end
