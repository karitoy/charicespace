class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.date :when
      t.string :where
      t.string :what
      t.string :remarks

      t.timestamps
    end
  end
end
