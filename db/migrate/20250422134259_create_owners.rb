class CreateOwners < ActiveRecord::Migration[8.0]
  def change
    create_table :owners do |t|
      t.string :name, null: false
      t.belongs_to :kind, null: false, foreign_key: { to_table: :owner_kinds }
      t.belongs_to :parent, null: true, foreign_key: { to_table: :owners }

      t.timestamps
    end
  end
end
