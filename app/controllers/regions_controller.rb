# frozen_string_literal: true

class RegionsController < ApplicationController
  def index
    fetch_regions
    respond_with_format
  end

  private

  def fetch_regions
    @regions = Region.all
  end

  def respond_with_format
    respond_to(&method(:choose_format))
  end

  def choose_format(format)
    format.json { render_json }
    format.html { render_html }
  end

  def render_json
    render json: @regions, each_serializer: RegionSerializer
  end

  def render_html
    render "regions/index"
  end
end
