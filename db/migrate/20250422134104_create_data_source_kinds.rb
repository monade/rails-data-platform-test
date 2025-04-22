class CreateDataSourceKinds < ActiveRecord::Migration[8.0]
  def change
    create_table :data_source_kinds do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
