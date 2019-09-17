Rails.application.routes.draw do
  devise_for :users
  resources :discounts
  resources :fittings
  resources :dosifications
  resources :orders
  resources :combos
  resources :branches
  resources :products
  resources :categories
  root 'main#index'

  # Products
  get '/products/:id/branches' => 'products#branches'
  get '/products/:id/branches/new' => 'products#add_branch'
  post '/products/:id/branches/create' => 'products#add_product_branch'
  get '/update_branch_cost/:id' => 'products#update_branch_cost'
  post '/update_branch_cost_form/:id' => 'products#update_branch_cost_form'

  # Combos
  get '/combos/:id/products' => 'combos#products'
  get '/combos/:id/products/new' => 'combos#add_product'
  post '/combos/:id/products/create' => 'combos#add_product_combo'

  # Orders
  get '/orders/:id/products' => 'orders#products'
  get '/orders/:id/add_product' => 'orders#add_product'
  get '/orders/:id/add_combo' => 'orders#add_combo'
  post '/orders/:id/products/create_product' => 'orders#add_product_order'
  post '/orders/:id/products/create_combo' => 'orders#add_combo_order'
  get '/orders/:id/close' => 'orders#close'
  get '/orders/:id/print' => 'orders#print'
  get '/orders/:id/partial_print' => 'orders#partial_print'
  get '/order_details/:id' => 'orders#order_details'
  get '/order_now' => 'orders#order_now'
  get '/close_shift' => 'orders#close_shift'
  get '/remove_item/:id' => 'orders#remove_item'
  get '/disable_order/:id' => 'orders#disable_order'
  get '/enable_order/:id' => 'orders#enable_order'

  # Reports
  get '/reports' => 'reports#index'
  get '/orders_report' => 'reports#orders_report'
  get '/products_report' => 'reports#products_report'
  get '/orders_report_excel' => 'reports#orders_report_excel'
  get '/products_report_excel' => 'reports#products_report_excel'
  get '/accounting_report' => 'reports#accounting_report'
  get '/accounting_report_disabled' => 'reports#accounting_report_disabled'
  get '/accounting_txt' => 'reports#accounting_txt'
  get '/accounting_disabled_txt' => 'reports#accounting_disabled_txt'

  # Admin
  get '/users' => 'admin#users'
  get '/new_user' => 'admin#new_user'
  post '/create_user' => 'admin#create_user'
  get '/add_branch_to_user/:id' => 'admin#add_branch_to_user'
  post '/add_branch_to_user_post/:id' => 'admin#add_branch_to_user_post'


  get '/code_control_test' => 'dosifications#code_control_test'
  get '/test_code_control' => 'dosifications#test_code_control'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
