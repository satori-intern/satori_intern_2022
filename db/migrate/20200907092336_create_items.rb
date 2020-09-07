class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :board_id, :limit => 8
      t.integer :prev_id, :limit => 8
      t.integer :next_id, :limit => 8
      t.text :detail

      t.timestamps
    end
  end
end
