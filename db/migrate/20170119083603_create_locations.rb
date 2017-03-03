class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :altitude
      t.references :locatable, polymorphic: true, index: true

      t.timestamps null: false
    end

  end
end
