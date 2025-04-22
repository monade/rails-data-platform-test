require 'rails_helper'

RSpec.describe OwnerKind, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:owner_kind)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:owner_kind, name: nil)).to be_invalid
  end
end
