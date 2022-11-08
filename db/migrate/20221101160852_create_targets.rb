class CreateTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.integer :radius, null: false
      t.integer :latitude, null: false
      t.integer :longitude, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :topic, null: false, foreign_key: true
      t.timestamps
    end
  end
end
