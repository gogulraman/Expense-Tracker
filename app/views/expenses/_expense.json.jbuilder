json.extract! expense, :id, :invoice_number, :category, :description, :amount, :statusEmp, :created_at, :updated_at
json.url expense_url(expense, format: :json)
