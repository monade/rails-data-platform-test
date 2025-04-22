FactoryBot.define do
  factory :region do
    sequence(:name) { |n| "Region #{n}" }
  end

  factory :district do
    sequence(:name) { |n| "District #{n}" }
    association :region
  end

  factory :data_source_kind do
    sequence(:name) { |n| "DataSource Kind #{n}" }
  end

  factory :data_source do
    sequence(:name) { |n| "DataSource #{n}" }
    association :kind, factory: :data_source_kind
    association :district
  end

  factory :owner_kind do
    sequence(:name) { |n| "Owner Kind #{n}" }
  end

  factory :owner do
    sequence(:name) { |n| "Owner #{n}" }
    association :kind, factory: :owner_kind
    # parent is optional, so we don't set it by default
  end

  factory :data_point do
    value { rand(1.0..100.0) }
    detected_at { Time.current }
    association :data_source
    association :owner
  end
end
