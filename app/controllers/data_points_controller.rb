# frozen_string_literal: true

class DataPointsController < ApplicationController
  def index
    @data_points = DataPoint.in_date_range(5.days.ago, Time.current)

    respond_to do |format|
      format.json { render json: @data_points, each_serializer: DataPointSerializer }
      format.html { render "data_points/index" }
    end
  end
end
