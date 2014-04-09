class CreateAprendices < ActiveRecord::Migration
  def change
    create_table :aprendices do |t|
      t.string :name
      t.references :tipo_documento
      t.string :num_document
      t.references :programa
      t.string :ficha

      t.timestamps
    end
    add_index :aprendices, :tipo_documento_id
    add_index :aprendices, :programa_id
  end
end
