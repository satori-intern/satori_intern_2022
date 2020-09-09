class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :list_id, :limit => 8
      t.integer :index, :limit => 8
      t.text :detail

      t.timestamps
    end
  end
end
