class DataPoint < ApplicationRecord
  belongs_to :data_source
  belongs_to :owner
end
