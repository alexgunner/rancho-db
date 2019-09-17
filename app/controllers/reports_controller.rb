class ReportsController < ApplicationController
	def index

	end

	def orders_report
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)
		
		store = params[:store]["store_id"]
		
		@orders = []
		@total_sold = 0
		@total_sold2 = 0
		Order.all.each do |order|
			if order.created_at >= @init_date and order.created_at <= (@final_date +1.day) and order.status == true and order.branch_id.to_s == store.to_s
				@orders.push(order)
				@total_sold += order.total_order_amount
			end
		end
	end

	def products_report
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)


		@branch_products = BranchProduct.all
	end

	def orders_report_excel
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)

		@orders = []
		@total_sold = 0
		Order.all.each do |order|
			if order.created_at >= @init_date and order.created_at <= @final_date and order.status == true
				@orders.push(order)
				order.order_items.each do |order_item|
					if order_item.branch_product_id != nil
						@total_sold += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost
					else
						@total_sold += order_item.quantity * Combo.find(order_item.combo_id).sale_cost
					end
				end
			end
		end

		render xlsx: "orders_report"
	end

	def products_report_excel
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)


		@branch_products = BranchProduct.all

		render xlsx: "products_report"
	end

	def accounting_report
		
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)

		@invoices = Invoice.where(invoice_date: @init_date..@final_date)

		@orders = []
		@total_sold = 0
		Order.all.each do |order|
			if order.created_at >= @init_date and order.created_at <= @final_date and order.status == true and !order.nit.empty?
				@orders.push(order)
				order.order_items.each do |order_item|
					if order_item.branch_product_id != nil
						@total_sold += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost
					else
						@total_sold += order_item.quantity * Combo.find(order_item.combo_id).sale_cost
					end
				end
			end
		end

		filepath = "#{Rails.root}/public/accounting_report.txt"

		File.open(filepath, "w") do |ar|
			@invoices.each_with_index do |invoice, index|
				if !Invoice.find_by(order_id: invoice.order.id).nil?
					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						valid = "V"
					else
						valid = "A"
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						if invoice.order.nit.empty?
							txt_nit = "00"
						else
							txt_nit = invoice.order.nit.to_s
						end
					else
						txt_nit = "00"
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						if invoice.order.name.empty?
							txt_name = "SN"
						else
							txt_name = invoice.order.name.upcase
						end
					else
						txt_name = "ANULADA"
					end

					total = 0
					invoice.order.order_items.each do |order_item| 
						if order_item.branch_product_id != nil 
							total += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost 
						else 
							total += order_item.quantity * Combo.find(order_item.combo_id).sale_cost 
						end 
					end 

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						#txt_total = number_to_currency(total, unit: "", separator: ",", delimiter: ".", precision: 2)
						txt_total = total
					else
						txt_total = 0
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						txt_control_code = invoice.order.code_control invoice.id, invoice.order.nit.to_i, total
						txt_control_code = txt_control_code.to_s
					else
						txt_control_code = "0"
					end

					txt_row = "3|" + (index + 1).to_s + "|" + invoice.order.created_at.strftime("%d/%m/%Y").to_s + "|" + Invoice.find_by(order_id: invoice.order.id).id.to_s + "|" + Dosification.first.authorization_number + "|" + valid + "|" + txt_nit + "|" + txt_name + "|" + txt_total.to_s + "|0.00|0.00|0.00|" + txt_total.to_s + "|0.00|" + txt_total.to_s + "|" + (txt_total * 0.13).round(2).to_s + "|" + txt_control_code
					ar.puts txt_row
				end
			end
		end
	end


	def accounting_report_disabled
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)

		@invoices = Invoice.where(invoice_date: @init_date..@final_date)

		@orders = []
		@total_sold = 0
		Order.all.each do |order|
			if order.created_at >= @init_date and order.created_at <= @final_date and order.status == true and order.order_state == false
				@orders.push(order)
				order.order_items.each do |order_item|
					if order_item.branch_product_id != nil
						@total_sold += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost
					else
						@total_sold += order_item.quantity * Combo.find(order_item.combo_id).sale_cost
					end
				end
			end
		end

		filepath = "#{Rails.root}/public/accounting_report_disabled.txt"
		count = 0
		File.open(filepath, "w") do |ar|
			@invoices.each_with_index do |invoice, index|
				if !Invoice.find_by(order_id: invoice.order.id).nil? and invoice.order.order_state == false
					count += 1
					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						valid = "V"
					else
						valid = "A"
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						if invoice.order.nit.empty?
							txt_nit = "00"
						else
							txt_nit = invoice.order.nit.to_s
						end
					else
						txt_nit = "00"
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						if invoice.order.name.empty?
							txt_name = "SN"
						else
							txt_name = invoice.order.name.upcase
						end
					else
						txt_name = "ANULADA"
					end

					total = 0
					invoice.order.order_items.each do |order_item| 
						if order_item.branch_product_id != nil 
							total += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost 
						else 
							total += order_item.quantity * Combo.find(order_item.combo_id).sale_cost 
						end 
					end 

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						#txt_total = number_to_currency(total, unit: "", separator: ",", delimiter: ".", precision: 2)
						txt_total = total
					else
						txt_total = 0
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						txt_control_code = invoice.order.code_control invoice.id, invoice.order.nit.to_i, total
						txt_control_code = txt_control_code.to_s
					else
						txt_control_code = "0"
					end

					txt_row = "3|" + (count).to_s + "|" + invoice.order.created_at.strftime("%d/%m/%Y").to_s + "|" + Invoice.find_by(order_id: invoice.order.id).id.to_s + "|" + Dosification.first.authorization_number + "|" + valid + "|" + txt_nit + "|" + txt_name + "|" + txt_total.to_s + "|0.00|0.00|0.00|" + txt_total.to_s + "|0.00|" + txt_total.to_s + "|" + (txt_total * 0.13).round(2).to_s + "|" + txt_control_code
					ar.puts txt_row
				end
			end
		end

	end

	def accounting_txt
		send_file("#{Rails.root}/public/accounting_report.txt", filename: "accounting.txt")
	end

	def accounting_disabled_txt
		send_file("#{Rails.root}/public/accounting_report_disabled.txt", filename: "accounting_report_disabled.txt")
	end
end
