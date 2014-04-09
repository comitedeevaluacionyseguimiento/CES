class CreateCommitteesMembers < ActiveRecord::Migration
  def change
    create_table :committees_members do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
