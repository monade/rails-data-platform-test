class CreateDistricts < ActiveRecord::Migration[8.0]
  def change
    create_table :districts do |t|
      t.string :name
      t.belongs_to :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
