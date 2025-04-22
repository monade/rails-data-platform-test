module RegionsHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
    base_title = "Regions"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def region_name(region)
    region.name
  end

  def region_description(region)
    region.description
  end

  def region_population(region)
    number_with_delimiter(region.population, delimiter: ",")
  end

  def region_area(region)
    number_with_delimiter(region.area, delimiter: ",")
  end
end
