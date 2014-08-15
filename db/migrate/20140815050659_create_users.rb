class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password
      t.string :avatar
      t.string :street
      t.string :city
      t.string :country
      t.string :birthday
      t.string :birthcity
      t.string :birthcountry
      t.integer :videonumber
      t.integer :lastcomment
      t.integer :lastpost
      t.text :aboutme
      t.string :authorization_token

      t.timestamps
    end
  end
end
