class Invoice < ApplicationRecord
  belongs_to :order

  def self.fix_invoices
  	invoices = Invoice.all
  	invoices.each do |invoice|
  		invoice.name = invoice.order.name
  		invoice.nit = invoice.order.nit
  		invoice.invoice_number = invoice.id
  		invoice.invoice_date = invoice.created_at.to_date
  		invoice.invoice_authorization = Dosification.first.authorization_number
  		invoice.invoice_amount = invoice.order.order_total
  		invoice.invoice_code = invoice.order.code_control invoice.id, invoice.order.nit.to_i, invoice.order.order_total
      invoice.save
  	end
  end
end
