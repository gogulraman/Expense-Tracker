class AddEmployeeIdToExpenses < ActiveRecord::Migration[6.1]
  def change
    add_column :expenses, :employee_id, :integer
    add_index :expenses, :employee_id
  end
end
