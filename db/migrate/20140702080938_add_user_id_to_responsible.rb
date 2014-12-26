class AddUserIdToResponsible < ActiveRecord::Migration
  def change
    add_column :responsibles, :user_id, :integer
    add_column :responsibles, : 
  end
end
