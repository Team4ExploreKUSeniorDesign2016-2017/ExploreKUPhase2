class CreateParkingExceptions < ActiveRecord::Migration
  def change
    create_table :parking_exceptions do |t|
      t.string :description
      t.references :parking_lot, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
