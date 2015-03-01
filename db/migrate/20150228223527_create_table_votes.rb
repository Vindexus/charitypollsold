class CreateTableVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :option_id
      t.integer :user_id
      t.boolean :verified
      t.timestamps null: false
    end
  end
end
