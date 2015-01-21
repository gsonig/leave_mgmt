class ChangeStatusToLeaves < ActiveRecord::Migration
  def change
  	remove_column :leaves, :status, :string
  	add_column :leaves, :status, :string, default: 'pending'
  end
end
