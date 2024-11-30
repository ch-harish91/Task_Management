class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
