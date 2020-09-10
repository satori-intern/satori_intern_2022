class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :list_id, :limit => 8, null: false
      t.integer :index, :limit => 8, null: false
      t.text :detail, null: false

      t.timestamps
    end
  end
end
