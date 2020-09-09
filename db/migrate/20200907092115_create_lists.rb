class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.integer :board_id, :limit => 8, null: false
      t.integer :index, :limit => 8, null: false

      t.timestamps
    end
  end
end
