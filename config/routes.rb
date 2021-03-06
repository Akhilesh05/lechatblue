Lechatblue::Application.routes.draw do
	mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
	resources :pizzas
	root "welcome#index"
	get "menu-book", to: "welcome#menu_book", as: :menu_book
	get "menu-book/:category", constraints: {category: /(pizzas|roasted-chicken|drinks)/}, to: "welcome#menu_category", as: :menu_category
	get "place-order", to: "welcome#place_order", as: :place_order
	match "create-order(/:pizza_id)", constraints: {pizza_id: /[0-9]+/}, to: "welcome#create_order", as: :create_order, via: [:get, :post]
	get "create-order/cancel", to: "welcome#create_order", cancel: true
	get "create-order/remove-pizza/:id", to: "welcome#create_order", remove_pizza: true, as: :remove_pizza
	match "confirm-order", to: "welcome#confirm_order", as: :confirm_order, via: [:get, :post]
	get "confirm-order/resend-confirmation-code", as: :resend_confirmation_code, resend: true, to: "welcome#confirm_order"
	post "delivery-receipt", to: "welcome#delivery_receipt"
	get "about-us", to: "welcome#about_us", as: :about_us
	post "ajax/get_pizza_details.json", format: false, to: "ajax#get_pizza_details"
	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	# root 'welcome#index'

	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
end
