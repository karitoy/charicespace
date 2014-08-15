class Videos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
			t.integer :user_id
			t.integer :videonumber, default: 1
			t.string	:filename
			t.string	:thumbnail
			t.string	:title
			t.string	:caption
			t.integer	:views
			t.string	:responseto
			t.timestamps
     end
  end
end
