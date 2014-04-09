class CreateHistorias < ActiveRecord::Migration
  def change
    create_table :historias do |t|
      t.references :aprendiz
      t.references :queja
      t.references :comite
      t.references :acta
      t.string :tipo_recomendacion
      t.text :llamada_atencion

      t.timestamps
    end
    add_index :historias, :aprendiz_id
    add_index :historias, :queja_id
    add_index :historias, :comite_id
    add_index :historias, :acta_id
  end
end
