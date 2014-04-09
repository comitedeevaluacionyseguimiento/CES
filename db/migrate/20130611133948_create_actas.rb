class CreateActas < ActiveRecord::Migration
  def change
    create_table :actas do |t|
      t.string :fecha
      t.string :hora_inicio
      t.string :hora_terminacion
      t.string :objetivo_de_la_reunion
      t.text :desarrollo_reunion
      t.text :conclusiones
      t.string :subdirector
      t.references :comite
      t.integer :configuracion_id
      t.string :num_acta
      t.string :fecha_creacion

      t.timestamps
    end
    add_index :actas, :comite_id
    add_index :actas, :configuracion_id
  end
end
