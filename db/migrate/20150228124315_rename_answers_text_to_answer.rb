class RenameAnswersTextToAnswer < ActiveRecord::Migration
  def change
  	rename_column :answers, :text, :answer
  end
end
