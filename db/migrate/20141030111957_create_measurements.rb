class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.float :temperature
      t.float :pressure
      t.float :humidity

      t.timestamps
    end
  end
end
