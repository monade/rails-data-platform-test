# frozen_string_literal: true

class Owner < ApplicationRecord
  belongs_to :kind, class_name: "OwnerKind"
  belongs_to :parent, class_name: "Owner", optional: true
end
