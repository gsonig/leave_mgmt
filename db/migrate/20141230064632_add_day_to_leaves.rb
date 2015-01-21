class AddDayToLeaves < ActiveRecord::Migration
  def change
		add_column :leaves, :day, :string
  end
end
