class CreateDataPoints < ActiveRecord::Migration[8.0]
  def change
    create_table :data_points do |t|
      t.float :value, null: false
      t.datetime :detected_at, null: false
      t.belongs_to :data_source, null: false, foreign_key: true
      t.belongs_to :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
