class RemovePrevIdToLists < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :prev_id
    rename_column :items, :next_id, :index
    remove_column :lists, :prev_id
    rename_column :lists, :next_id, :index
  end
end
