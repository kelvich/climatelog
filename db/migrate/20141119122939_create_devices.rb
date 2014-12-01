class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :mac
      t.string :owner
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
