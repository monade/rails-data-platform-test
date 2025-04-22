require 'rails_helper'

RSpec.describe DataSourceKind, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:data_source_kind)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:data_source_kind, name: nil)).to be_invalid
  end
end
