# frozen_string_literal: true

class DataPointsController < ApplicationController
  def index
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]).beginning_of_day : 5.days.ago
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]).end_of_day : Time.current

    @data_points = DataPoint.in_date_range(start_date, end_date)

    respond_to do |format|
      format.json { render json: @data_points, each_serializer: DataPointSerializer }
      format.html { render "data_points/index" }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("data_points_chart",
                                   partial: "data_points/chart",
                                   locals: { data_points: @data_points }) }
    end
  end
end
