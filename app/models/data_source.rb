# frozen_string_literal: true

class DataSource < ApplicationRecord
  belongs_to :kind, class_name: "DataSourceKind"
  belongs_to :district
end
