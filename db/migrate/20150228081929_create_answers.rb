class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :text
      t.belongs_to :poll, index: true

      t.timestamps null: false
    end
    add_foreign_key :answers, :polls
  end
end
