class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|

      t.text :line_items
      t.string :email

      t.timestamps
    end
  end
end
