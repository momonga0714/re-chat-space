class AddNameIndexToGroups < ActiveRecord::Migration[5.0]
  
  def change
    add_index :groups, :group_name ,unique: true
  end
end
