class AlterTargerTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :targets, :latitude
    remove_column :targets, :longitude
    add_column :targets, :location, :point, geographic: true
  end
end
