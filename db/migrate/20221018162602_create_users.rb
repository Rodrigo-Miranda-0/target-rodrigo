# This migration creates the user table
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :gender

      t.timestamps
    end
  end
end
