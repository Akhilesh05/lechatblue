Lechatblue::Application.routes.draw do
	resources :pizzas

	root "welcome#index"
	get "menu-book", to: "welcome#menu_book", as: :menu_book
	get "menu-book/:category", constraints: {category: /(pizzas|roasted-chicken|drinks)/}, to: "welcome#menu_category", as: :menu_category
	match "place-order", to: "welcome#place_order", as: :place_order, via: [:get, :post]
	get "place-order/:pizza_id(/:pizza_name)", constraints: {pizza_id: /[0-9]+/, pizza_name:/[a-zA-Z0-9-_'.~% ]+/}, to: "welcome#create_order", as: :create_order
	#post "place-order", to: "welcome#place_order", as: :place_order
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
