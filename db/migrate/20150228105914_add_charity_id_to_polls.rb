class AddCharityIdToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :charity_id, :integer
  end
end
