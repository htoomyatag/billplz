class CreatePizzaSizeToppings < ActiveRecord::Migration[7.0]
  def change
    create_table :pizza_size_toppings do |t|
      t.references :pizza_size, null: false, foreign_key: true
      t.references :topping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
