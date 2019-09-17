class Order < ApplicationRecord
	belongs_to :branch
	has_many :order_items
	has_many :order_discounts
	has_one :invoice

	include Algorithm::Literalizer
	include Invoicing::ControlCodeGenerator

	def order_total
		total = 0
        order_items.each do |order_item| 
	        if order_item.branch_product_id != nil 
	        	if order_item.branch_product_id != 23 and order_item.branch_product_id != 24 and order_item.branch_product_id != 25 and order_item.branch_product_id != 26 and order_item.branch_product_id != 27 and order_item.branch_product_id != 28 and order_item.branch_product_id != 29 and order_item.branch_product_id != 64
	        		total += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost 	
	        	end
	        	
	        else 
	        	total += order_item.quantity * Combo.find(order_item.combo_id).sale_cost 
	        end 
	    end 
	    if order_state == true or order_state.nil? 
	       return total
	    else 
	        return 0
	    end 
	    
	end

	def	literal amount
		literate_es amount
	end

	def code_control num, nit, amount
		dosi = Dosification.first
		auth_number = dosi.authorization_number
		in_key = dosi.dosification_key
		in_number = num
		in_nit = nit
		in_am = amount
		in_year = created_at.strftime("%Y")
		in_month = created_at.strftime("%m")
		in_day = created_at.strftime("%d")
		in_date = in_year.to_s + in_month.to_s + in_day.to_s
		in_final_date = in_date.to_i
		control_code_for authorization: auth_number, number: in_number, nit: in_nit, date: in_final_date, amount: in_am, key: in_key
	end

	def show_code_control auth_number, in_number, in_nit, in_final_date, in_am, in_key
		control_code_for authorization: auth_number, number: in_number, nit: in_nit, date: in_final_date, amount: in_am, key: in_key
	end

	def self.get_orders_since
		#orders = Order.where(branch_id: 2)

		#start id hipermaxi
		start_id = 6961
		end_id = 7028

		#start id mikhuna
		#start_id = 7397
		#end_id = 7487

		orders = []
		while start_id <= end_id do
			if start_id != 6689
				orders.push Order.find(start_id)	
			end			
			start_id += 1
		end

	    
	    filepath = "#{Rails.root}/public/orders.txt"

	    order_count = 0
		File.open(filepath, "w") do |order_row|
			row_content = ""
			orders.each do |order|
				#row_content += "'" + order.created_at.to_s + "', "
				
				row_content = "order" + order_count.to_s + " = Order.create" 

				if order.name.nil? or order.name == ""
					row_content += " name: ''"
				else
					row_content += " name: '" + order.name.to_s + "'"
				end

				if order.nit.nil? or order.nit == ""
					row_content += ", nit: ''"
				else
					row_content += ", nit: '" + order.nit.to_s + "'"
				end

				if order.amount_payed.nil?
					row_content += ", amount_payed: 0"
				else
					row_content += ", amount_payed: " + order.amount_payed.to_s
				end

				if order.details.nil? or order.details == ""
					row_content += ", details: ''"
				else
					row_content += ", details: '" + order.details.to_s + "'"
				end

				row_content += + ", branch_id: " + order.branch_id.to_s + ", status: " + order.status.to_s + ", total_order_amount: " + order.order_total.to_s

				order_row.puts row_content
				order_row.puts "order" + order_count.to_s + ".created_at = '" + order.created_at.to_s + "'"
				order_row.puts "order" + order_count.to_s + ".save"
				

				if !order.invoice.nil?
					invoice_row = "Invoice.create order_id: order" + order_count.to_s + ".id.to_s"

					if order.name.nil? or order.name == ""
						invoice_row += ", name: ''"
					else
						invoice_row += ", name: '" + order.name.to_s + "'"
					end

					if order.nit.nil? or order.nit == ""
						invoice_row += ", nit: ''"
					else
						invoice_row += ", nit: '" + order.nit.to_s + "'"
					end

					invoice_row += ", invoice_number: " + order.invoice.id.to_s + ", invoice_date: '" + order.created_at.to_s + "', invoice_authorization: '" + Dosification.first.authorization_number + "', invoice_amount: " + order.order_total.to_s + ", invoice_code: '" + order.code_control(order.invoice.id, order.nit, order.order_total) + "'"
					order_row.puts invoice_row
				end
				order_count += 1
			end
			#order_row.puts row_content
		end

  	end

end
