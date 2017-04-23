class CreateParkingLots < ActiveRecord::Migration
  def change
    create_table :parking_lots do |t|
      t.integer :lot
      t.string :restrictions
      t.integer :Gold
      t.integer :Blue
      t.integer :Red
      t.integer :Yellow
      t.integer :DaisyHill
      t.integer :GSPCorbin
      t.integer :OliverMcCarthyHalls
      t.integer :AlumniPlace
      t.integer :JayhawkTowers
      t.integer :SunflowerApartments
      t.integer :Handicap
      t.integer :Meter
      t.integer :PF
      t.integer :Load
      t.integer :Reserved
      t.integer :Service
      t.integer :State
      t.integer :Other
      t.integer :Total
      t.integer :Cycle

      t.timestamps null: false
    end
  end
end
