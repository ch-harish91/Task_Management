class CreateJoinTableUsersRoles < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :roles do |t|
      t.index %i[user_id role_id]
      t.index %i[role_id user_id]

      t.timestamps
    end
  end
end
