class ChangeFormatToLeaves < ActiveRecord::Migration
  def up
		change_column :leaves, :start_date, :datetime
		change_column :leaves, :end_date, :datetime
		change_column :leaves, :no_of_day, :float
		change_column :users, :no_of_leave, :float
		change_column :users, :balance_leave, :float	
  end
	def down
		change_column :leaves, :start_date, :date
		change_column :leaves, :end_date, :date
		change_column :leaves, :no_of_day, :integer
		change_column :users, :no_of_leave, :integer
		change_column :users, :balance_leave, :integer	
	
	end
end
