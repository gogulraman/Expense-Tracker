class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.integer :invoice_number
      t.string :category
      t.string :description
      t.integer :amount
      t.string :statusEmp

      t.timestamps
    end
  end
end
