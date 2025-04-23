require 'rails_helper'

RSpec.describe "DataPoints", type: :request do
  describe "GET /index" do
    context "with HTML format" do
      before do
        create_list(:data_point, 3)
        get data_points_path
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "renders the index template" do
        expect(response).to render_template("data_points/index")
      end
    end

    context "with JSON format" do
      before do
        @data_points = create_list(:data_point, 3)
        get data_points_path, as: :json
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns all data points as JSON" do
        body = JSON.parse(response.body)
        expect(body.length).to eq(3)
      end

      it "includes relevant data point attributes" do
        body = JSON.parse(response.body)
        expect(body.first).to include('id', 'value', 'detected_at')
      end
    end

    context "with filtering parameters" do
      before do
        region = create(:region)
        district = create(:district, region: region)
        data_source = create(:data_source, district: district)
        owner = create(:owner)

        # Create data points for different dates
        @recent_point = create(:data_point, data_source: data_source, owner: owner, detected_at: 1.day.ago)
        @old_point = create(:data_point, data_source: data_source, owner: owner, detected_at: 1.month.ago)
      end

      it "filters data points by date range in JSON response" do
        date_from = 2.days.ago.to_s
        date_to = Time.current.to_s

        get data_points_path, params: { date_from: date_from, date_to: date_to }, as: :json

        body = JSON.parse(response.body)
        expect(body.length).to eq(1)
        expect(body.first['id']).to eq(@recent_point.id)
      end

      it "filters data points by region in JSON response" do
        region = @recent_point.data_source.district.region

        get data_points_path, params: { region_id: region.id }, as: :json

        body = JSON.parse(response.body)
        expect(body.length).to eq(2)
      end

      it "filters data points by owner in JSON response" do
        owner = @recent_point.owner

        get data_points_path, params: { owner_id: owner.id }, as: :json

        body = JSON.parse(response.body)
        expect(body.length).to eq(2)
      end

      it "applies granularity to JSON response" do
        # Create multiple points within the same hour
        time_base = Time.current.beginning_of_hour
        points = []
        5.times do |i|
          points << create(:data_point, value: i+1, detected_at: time_base + i.minutes)
        end

        get data_points_path, params: { granularity: 'hour' }, as: :json

        body = JSON.parse(response.body)
        # Check that we have an aggregated result and not individual points
        hour_data = body.find { |item| Time.parse(item['detected_at']).beginning_of_hour == time_base }
        expect(hour_data).to be_present

        # Average of values 1,2,3,4,5 = 3
        expect(hour_data['value']).to eq(3)
      end
    end
  end
end
