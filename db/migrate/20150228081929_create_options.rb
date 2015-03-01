class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.belongs_to :poll, index: true

      t.timestamps null: false
    end
    add_foreign_key :options, :polls
  end
end
