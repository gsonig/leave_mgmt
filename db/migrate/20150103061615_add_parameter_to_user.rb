class AddParameterToUser < ActiveRecord::Migration
  def change
		add_column :users, :no_of_leave, :integer, default: 0
		add_column :users, :balance_leave, :integer  
    add_column :leaves, :no_of_day, :integer
  end
end
