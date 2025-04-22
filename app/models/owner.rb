class Owner < ApplicationRecord
  belongs_to :kind
  belongs_to :parent
end
