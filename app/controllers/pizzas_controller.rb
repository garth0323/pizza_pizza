class PizzasController < ApplicationController
	before_action :pizza_server_new

	def index
		@pizzas = @pizza_server.pizzas
	end

	def show
		@pizza = params
		begin
		  @toppings = @pizza_server.toppings_on_existing_pizza params[:pizza_id]
		rescue => error
			flash[:error] = "We seem to have run into a problem locating those toppings, want to add a new one?"
		  @toppings = nil
		end
	end

	def add_topping
		@pizza = {'pizza_id' => params[:pizza_id].to_i, 'name' => params[:name], 'description' => params[:description]}
		new_topping = create_topping params["topping"]
		@pizza_server.add_topping_to_pizza params[:pizza_id].to_i, new_topping['id']
		@toppings = @pizza_server.toppings_on_existing_pizza params[:pizza_id] #do I need to do this here?
		render :show
	end

	def new
		@pizza_server.create_pizza params[:name], params[:description]
		@pizzas = @pizza_server.pizzas
		render :index
	end

	private

	def pizza_server_new
		@pizza_server = PizzaServer.new
	end

	def create_topping topping
		@pizza_server.create_topping topping
	end

end