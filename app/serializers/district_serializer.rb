# frozen_string_literal: true

class DistrictSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :region
end
