class Region < ApplicationRecord
  has_many :districts, dependent: :destroy
end
