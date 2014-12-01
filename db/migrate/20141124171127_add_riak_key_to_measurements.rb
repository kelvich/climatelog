class AddRiakKeyToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :riak_key, :string
    add_column :measurements, :device_id, :integer
  end
end
