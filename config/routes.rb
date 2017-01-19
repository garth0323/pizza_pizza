Rails.application.routes.draw do
	get 'pizza', to: 'pizzas#show'
	post 'pizzas/new', to: 'pizzas#new'
	post 'pizzas/add_topping', to: 'pizzas#add_topping'
	root to: 'pizzas#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
