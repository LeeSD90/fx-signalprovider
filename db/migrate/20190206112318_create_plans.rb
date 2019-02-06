class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :interval
      t.integer :duration
      t.string :currency
      t.integer :price

      t.timestamps
    end
  end
end
