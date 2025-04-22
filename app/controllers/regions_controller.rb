# frozen_string_literal: true

class RegionsController < ApplicationController
  def index
    @regions = Region.all

    respond_to do |format|
      format.json { render json: @regions, each_serializer: RegionSerializer }
      format.html { render "regions/index" }
    end
  end
end
