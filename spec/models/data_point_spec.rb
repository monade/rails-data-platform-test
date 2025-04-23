require 'rails_helper'

RSpec.describe DataPoint, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:data_point)).to be_valid
  end

  it "is invalid without a value" do
    expect(FactoryBot.build(:data_point, value: nil)).to be_invalid
  end

  it "has valid associations" do
    expect(FactoryBot.build(:data_point).data_source).to be_a(DataSource)
    expect(FactoryBot.build(:data_point).owner).to be_a(Owner)
  end

  context "date filtering scopes" do
    before do
      @early_point = create(:data_point, detected_at: 2.days.ago)
      @middle_point = create(:data_point, detected_at: 1.day.ago)
      @recent_point = create(:data_point, detected_at: 1.hour.ago)
    end

    it "filters by date range" do
      date_from = 36.hours.ago
      date_to = Time.current

      expect(DataPoint.in_date_range(date_from, date_to)).to include(@recent_point, @middle_point)
      expect(DataPoint.in_date_range(date_from, date_to)).not_to include(@early_point)
    end

    it "filters from a specific date" do
      date_from = 36.hours.ago

      expect(DataPoint.in_date_range(date_from, nil)).to include(@recent_point, @middle_point)
      expect(DataPoint.in_date_range(date_from, nil)).not_to include(@early_point)
    end

    it "filters to a specific date" do
      date_to = 12.hours.ago

      expect(DataPoint.in_date_range(nil, date_to)).to include(@early_point, @middle_point)
      expect(DataPoint.in_date_range(nil, date_to)).not_to include(@recent_point)
    end
  end

  context "granularity scopes" do
    before do
      @time_base = Time.current.beginning_of_day

      # Create data points for minute granularity test
      @minute1_points = []
      5.times do |i|
        @minute1_points << create(:data_point, value: i + 1, detected_at: @time_base + 1.minute)
      end

      @minute2_points = []
      5.times do |i|
        @minute2_points << create(:data_point, value: i + 6, detected_at: @time_base + 2.minutes)
      end

      # Create data points for hour granularity test
      @hourly_points = {}

      24.times do |hour|
        @hourly_points[hour] = []
        10.times do |i|
          value = hour * 10 + i + 1  # Different values for each point
          @hourly_points[hour] << create(:data_point, value: value, detected_at: @time_base + hour.hours + i.minutes)
        end
      end

      # Create data points for day granularity test
      @day1_points = []
      20.times do |i|
        @day1_points << create(:data_point, value: i + 1, detected_at: @time_base + i.hours)
      end

      @day2_points = []
      20.times do |i|
        @day2_points << create(:data_point, value: i + 21, detected_at: @time_base + 1.day + i.hours)
      end
    end

    it "aggregates data by minutes" do
      result = DataPoint.by_granularity(:minute)

      expect(result.keys.first).to be_a(Time)
      expect(result.values.first).to be_a(Numeric)

      minute1_avg = @minute1_points.sum(&:value) / @minute1_points.size.to_f
      minute2_avg = @minute2_points.sum(&:value) / @minute2_points.size.to_f

      expect(result[@time_base + 1.minute]).to eq(minute1_avg)
      expect(result[@time_base + 2.minutes]).to eq(minute2_avg)
      expect(result.size).to be >= 2
    end

    it "aggregates data by hours" do
      result = DataPoint.by_granularity(:hour)

      expect(result.keys.first).to be_a(Time)
      expect(result.values.first).to be_a(Numeric)

      # Check each hour has the correct average
      24.times do |hour|
        hour_key = (@time_base + hour.hours).beginning_of_hour
        expected_avg = @hourly_points[hour].sum(&:value) / @hourly_points[hour].size.to_f

        expect(result[hour_key]).to eq(expected_avg)
      end

      expect(result.size).to eq(24)  # Should have exactly 24 hours
    end

    it "aggregates data by days" do
      result = DataPoint.by_granularity(:day)

      expect(result.keys.first).to be_a(Time)
      expect(result.values.first).to be_a(Numeric)

      day1_avg = @day1_points.sum(&:value) / @day1_points.size.to_f
      day1_key = @time_base.beginning_of_day

      day2_avg = @day2_points.sum(&:value) / @day2_points.size.to_f
      day2_key = (@time_base + 1.day).beginning_of_day

      expect(result[day1_key]).to eq(day1_avg)
      expect(result[day2_key]).to eq(day2_avg)
      expect(result.size).to be >= 2
    end
  end

  context "region and district scopes" do
    before do
      @region1 = create(:region, name: "Region 1")
      @region2 = create(:region, name: "Region 2")

      @district1 = create(:district, name: "District 1", region: @region1)
      @district2 = create(:district, name: "District 2", region: @region1)
      @district3 = create(:district, name: "District 3", region: @region2)

      @source1 = create(:data_source, district: @district1)
      @source2 = create(:data_source, district: @district2)
      @source3 = create(:data_source, district: @district3)

      @data_point1 = create(:data_point, data_source: @source1)
      @data_point2 = create(:data_point, data_source: @source2)
      @data_point3 = create(:data_point, data_source: @source3)
    end

    it "filters by region" do
      expect(DataPoint.in_region(@region1)).to include(@data_point1, @data_point2)
      expect(DataPoint.in_region(@region1)).not_to include(@data_point3)
    end

    it "filters by region name" do
      expect(DataPoint.in_region("Region 1")).to include(@data_point1, @data_point2)
      expect(DataPoint.in_region("Region 1")).not_to include(@data_point3)
    end

    it "filters by district" do
      expect(DataPoint.in_district(@district1)).to include(@data_point1)
      expect(DataPoint.in_district(@district1)).not_to include(@data_point2, @data_point3)
    end

    it "filters by district name" do
      expect(DataPoint.in_district("District 1")).to include(@data_point1)
      expect(DataPoint.in_district("District 1")).not_to include(@data_point2, @data_point3)
    end
  end

  context "data source and owner scopes" do
    before do
      @source1 = create(:data_source, name: "Source 1")
      @source2 = create(:data_source, name: "Source 2")
      @source3 = create(:data_source, name: "Source 3")


      @parent_owner = create(:owner, name: "Parent")
      @owner1 = create(:owner, name: "Owner 1", parent: @parent_owner)
      @owner2 = create(:owner, name: "Owner 2")
      @owner3 = create(:owner, name: "Owner 3")

      @data_point1 = create(:data_point, data_source: @source1, owner: @owner1)
      @data_point2 = create(:data_point, data_source: @source2, owner: @owner2)
      @data_point3 = create(:data_point, data_source: @source3, owner: @owner3)
    end

    it "filters by data source" do
      expect(DataPoint.from_source(@source1)).to include(@data_point1)
      expect(DataPoint.from_source(@source1)).not_to include(@data_point2, @data_point3)
    end

    it "filters by data source name" do
      expect(DataPoint.from_source("Source 1")).to include(@data_point1)
      expect(DataPoint.from_source("Source 1")).not_to include(@data_point2, @data_point3)
    end

    it "filters by owner" do
      expect(DataPoint.by_owner(@owner1)).to include(@data_point1)
      expect(DataPoint.by_owner(@owner1)).not_to include(@data_point2, @data_point3)
    end

    it "filters by owner name" do
      expect(DataPoint.by_owner("Owner 1")).to include(@data_point1)
      expect(DataPoint.by_owner("Owner 1")).not_to include(@data_point2, @data_point3)
    end

    it "filters by parent owner" do
      expect(DataPoint.by_parent_owner(@parent_owner)).to include(@data_point1)
      expect(DataPoint.by_parent_owner(@parent_owner)).not_to include(@data_point2, @data_point3)
    end
  end
end
