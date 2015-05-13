class CreateChangelogs < ActiveRecord::Migration
  def change
    create_table :changelogs do |t|
      t.belongs_to :history, index: true
      t.string :data_name
      t.string :data_from
      t.string :data_to

      t.timestamps null: false
    end
  end
end
