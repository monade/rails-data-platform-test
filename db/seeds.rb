# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


districts = FactoryBot.create_list(:district, 10)

owner_kinds = [
  FactoryBot.create(:owner_kind, name: "Privato"),
  FactoryBot.create(:owner_kind, name: "Azienda"),
  FactoryBot.create(:owner_kind, name: "Ente")
]

owners = [
  FactoryBot.create(:owner, name: "ABC Corp srl", kind: owner_kinds.second),
  FactoryBot.create(:owner, name: "Istituto Nazionale per le Nuove Tecnologie e le Ricerca", kind: owner_kinds.third)
]

owners += [
  FactoryBot.create(:owner, name: "Mario Rossi", kind: owner_kinds.first),
  FactoryBot.create(:owner, name: "Giovanni Bianchi", kind: owner_kinds.first),
  FactoryBot.create(:owner, name: "Luigi Verdi", kind: owner_kinds.first),
  FactoryBot.create(:owner, name: "Giuseppe Neri", kind: owner_kinds.first),
  FactoryBot.create(:owner, name: "Francesco Gialli", parent: owners.first, kind: owner_kinds.first),
  FactoryBot.create(:owner, name: "Giuseppe Neri", parent: owners.second, kind: owner_kinds.first)
]

data_source_kinds = [
  FactoryBot.create(:data_source_kind, name: "Gas"),
  FactoryBot.create(:data_source_kind, name: "Elettricità"),
  FactoryBot.create(:data_source_kind, name: "Acqua")
]

data_sources = [
  FactoryBot.create(:data_source, name: "Stazione Gas di Brescia", kind: data_source_kinds.first, district: districts.first),
  FactoryBot.create(:data_source, name: "Stazione Elettricità di Brescia", kind: data_source_kinds.second, district: districts.first),
  FactoryBot.create(:data_source, name: "Stazione Acqua di Brescia", kind: data_source_kinds.third, district: districts.first)
]

owners.each do |owner|
  (-1000..0).each do |i|
    FactoryBot.create(
      :data_point,
      owner: owner,
      data_source: data_sources.sample,
      detected_at: Time.current + i.hours + rand(0..59).minutes,
      value: rand(1.0..100.0)
    )
  end
end
