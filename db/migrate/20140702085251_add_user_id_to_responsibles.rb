class AddUserIdToResponsibles < ActiveRecord::Migration
  def change
    add_column :responsibles, :user_id, :integer
  end
end
