class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.references :user, index: true
      t.references :board, index: true, foreign_key: true
      t.timestamps
    end
  end
end
