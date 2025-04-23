class DataPoint < ApplicationRecord
  belongs_to :data_source
  belongs_to :owner

  scope :in_date_range, ->(start_date, end_date) {
    where(detected_at: start_date..end_date)
  }

  scope :from_source, ->(source) {
    if source.is_a?(DataSource)
      where(data_source: source)
    elsif source.is_a?(String)
      joins(:data_source).where(data_sources: { name: source })
    else
      raise ArgumentError, "Invalid argument type. Expected DataSource or String."
    end
  }

  scope :in_district, ->(district) {
    if district.is_a?(District)
      where(district: district)
    elsif district.is_a?(String)
      joins(:data_source).where(data_sources: { district: { name: district } })
    else
      raise ArgumentError, "Invalid argument type. Expected District or String."
    end
  }
end
