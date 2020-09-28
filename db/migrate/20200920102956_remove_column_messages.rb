class RemoveColumnMessages < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :message, :text
  end
end
