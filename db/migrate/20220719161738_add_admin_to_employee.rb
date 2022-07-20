class AddAdminToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :admin, :boolean, default: false
  end
end
