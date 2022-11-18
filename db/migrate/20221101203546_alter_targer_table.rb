class AlterTargerTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :targets, :latitude, :float
    remove_column :targets, :longitude, :float
    add_column :targets, :location, :st_point, geographic: true, null: false
  end
end
