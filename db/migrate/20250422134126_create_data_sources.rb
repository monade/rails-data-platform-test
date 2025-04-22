class CreateDataSources < ActiveRecord::Migration[8.0]
  def change
    create_table :data_sources do |t|
      t.string :name, null: false
      t.belongs_to :kind, null: false, foreign_key: { to_table: :data_source_kinds }
      t.belongs_to :district, null: true, foreign_key: true

      t.timestamps
    end
  end
end
