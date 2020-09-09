class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :board_id, :limit => 8
      t.integer :index, :limit => 8

      t.timestamps
    end
  end
end
