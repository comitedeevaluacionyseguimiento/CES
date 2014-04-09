class CreateFcomites < ActiveRecord::Migration
  def change
    create_table :fcomites do |t|
      t.string :fecha
      t.string :lugar
      t.string :tipo
      t.references :estado
     

      t.timestamps
    end
    add_index :fcomites, :estado_id
  end
end
