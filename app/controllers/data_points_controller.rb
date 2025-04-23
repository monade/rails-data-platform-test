# frozen_string_literal: true

class DataPointsController < ApplicationController
  def index
    @data_points = DataPoint.all

    respond_to do |format|
      format.json { render json: @data_points, each_serializer: DataPointSerializer }
      format.html { render "data_points/index" }
    end
  end
end
