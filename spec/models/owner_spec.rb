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
    parent = create(:owner, name: "Parent Owner")
    child = create(:owner, parent: parent, name: "Child 1")
    expect(child.parent).to eq(parent)
  end

  it "can have multiple children" do
    parent = create(:owner, name: "Parent Owner")
    child1 = create(:owner, parent: parent, name: "Child 1")
    child2 = create(:owner, parent: parent, name: "Child 2")

    expect(parent.children).to include(child1, child2)
  end

  it "can be found by parent" do
    parent = create(:owner, name: "Parent Owner")
    child = create(:owner, parent: parent, name: "Child 1")

    expect(Owner.of_parent(parent)).to include(child)
  end

  it "can be found by parent recursively" do
    parent = create(:owner, name: "Parent Owner")
    child1 = create(:owner, parent: parent, name: "Child 1")
    child2 = create(:owner, parent: child1, name: "Child 2")
    child3 = create(:owner, parent: child2, name: "Child 3")

    expect(Owner.of_parent(parent)).to include(child1, child2, child3)
  end
end
