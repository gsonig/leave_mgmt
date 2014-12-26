class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.text :subject
      t.text :comment
      t.date :date
      t.integer :responsible_id
      t.integer :user_id
      t.string :status
      t.text :leave_comment

      t.timestamps
    end
  end
end
