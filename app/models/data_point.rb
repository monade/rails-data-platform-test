class DataPoint < ApplicationRecord
  belongs_to :data_source
  belongs_to :owner

  scope :in_date_range, ->(start_date, end_date) {
    start = start_date.present? ? start_date : nil
    ending = end_date.present? ? end_date : nil

    if start.present? && ending.present?
      where("detected_at >= ? AND detected_at <= ?", start, ending)
    elsif start.present? && !ending.present?
      where("detected_at >= ?", start)
    elsif !start.present? && ending.present?
      where("detected_at <= ?", ending)
    else
      all
    end
  }

  scope :from_source, ->(source) {
    if source.present?
      if source.is_a?(DataSource)
        where(data_source: source)
      elsif source.is_a?(String)
        joins(:data_source).where(data_sources: { name: source })
      else
        raise ArgumentError, "Invalid argument type. Expected DataSource or String."
      end
    else
      all
    end
  }

  scope :in_district, ->(district) {
    if district.nil?
      all
    else
      if district.is_a?(District)
        where(district: district)
      elsif district.is_a?(String)
        joins(:data_source).where(data_sources: { district: { name: district } })
      else
        raise ArgumentError, "Invalid argument type. Expected District or String."
      end
    end
  }
end
