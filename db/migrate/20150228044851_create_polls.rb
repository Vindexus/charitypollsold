class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :question
      t.boolean :is_closed
      t.date :closed_date

      t.timestamps null: false
    end
  end
end
