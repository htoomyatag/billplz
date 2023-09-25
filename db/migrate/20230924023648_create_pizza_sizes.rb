class CreatePizzaSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :pizza_sizes do |t|
      t.string :name
      t.decimal :base_price

      t.timestamps
    end
  end
end
