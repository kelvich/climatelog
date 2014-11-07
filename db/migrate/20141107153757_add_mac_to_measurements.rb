class AddMacToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :mac, :string
  end
end
