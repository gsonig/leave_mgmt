class UpdateLeaveFeilds < ActiveRecord::Migration
  def change
    add_column :responsibles, :responsible_id, :integer
    remove_column :leaves, :responsible_id, :integer
  end
end
