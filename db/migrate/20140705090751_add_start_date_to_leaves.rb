class AddStartDateToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :start_date, :date
  end
end
