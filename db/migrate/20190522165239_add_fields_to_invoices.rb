class AddFieldsToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :name, :string
    add_column :invoices, :nit, :string
    add_column :invoices, :invoice_number, :integer
    add_column :invoices, :invoice_date, :date
    add_column :invoices, :invoice_authorization, :string
    add_column :invoices, :invoice_amount, :float
    add_column :invoices, :invoice_code, :string
  end
end
