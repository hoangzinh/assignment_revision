class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :editer_id
      t.integer :edited_id

      t.timestamps null: false
    end

    add_index :histories, [ :editer_id, :edited_id ]
  end
end
