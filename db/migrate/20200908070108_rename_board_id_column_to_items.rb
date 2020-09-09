class RenameBoardIdColumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :board_id, :list_id
  end
end
