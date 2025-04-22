require 'rails_helper'

RSpec.describe Owner, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:owner)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryBot.build(:owner, name: nil)).to be_invalid
  end

  it "has valid associations" do
    expect(FactoryBot.build(:owner).kind).to be_a(OwnerKind)
  end

  it "can have a parent owner" do
    parent = create(:owner)
    child = create(:owner, parent: parent)
    expect(child.parent).to eq(parent)
  end
end
