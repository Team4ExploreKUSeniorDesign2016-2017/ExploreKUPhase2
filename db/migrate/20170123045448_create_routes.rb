class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :number
      t.string :name
      t.string :end

      t.timestamps null: false
    end
  end
end
