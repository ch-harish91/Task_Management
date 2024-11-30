class CreateUserprojects < ActiveRecord::Migration[7.1]
  def change
    create_table :userprojects do |t|
      t.integer :user_id  
      t.integer :project_id  
      t.text :permissions  

      t.timestamps
    end
  end
end


#