class CreatePizzaTypes < ActiveRecord::Migration
  def change
    create_table :pizza_types do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.references :item, index: true

      t.timestamps null: false
    end
    add_foreign_key :pizza_types, :items
  end
end
