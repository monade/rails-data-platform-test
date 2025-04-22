# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Regions", type: :request do
  describe "GET /regions" do
    let!(:regions) { create_list(:region, 3) }
    context 'with html format' do
      it "returns a successful response" do
        get regions_path(format: :html)
        expect(response).to have_http_status(:ok)
      end

      it "renders the index template" do
        get regions_path(format: :html)
        expect(response).to render_template("regions/index")
      end
    end

    context 'with json format' do
      it "returns a successful response" do
        get regions_path(format: :json)
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct number of regions" do
        get regions_path(format: :json)
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(regions.size)
      end

      it "returns the correct attributes" do
        get regions_path(format: :json)
        json_response = JSON.parse(response.body)
        expect(json_response.first.keys).to include("id", "name")
      end
    end
  end
end
