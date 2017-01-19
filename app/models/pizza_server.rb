class PizzaServer
	include HTTParty
  base_uri 'https://pizzaserver.herokuapp.com'

  # List pizzas
  def pizzas
    response = self.class.get("/pizzas")
    readable_json(response)
  end

  # Create a pizza
  def create_pizza pizza_name, pizza_descripiton
  	query = {"pizza" => {"name" => "#{pizza_name}", "description" => "#{pizza_descripiton}"}}
    response = self.class.post("/pizzas", :query => query)
    readable_json(response)
  end

	# Create a topping
  def create_topping new_topping
  	query = {topping: {name: "#{new_topping}"}}
    response = self.class.post("/toppings", :query => query)
    readable_json(response)
  end

  # List toppings
  def toppings
    response = self.class.get("/toppings")
    readable_json(response)
  end

  # Add a topping to an existing pizza
  def add_topping_to_pizza pizza_id, topping_id
  	query = {topping_id: "#{topping_id}"}
    response = self.class.post("/pizzas/#{pizza_id}/toppings", :query => query)
    readable_json(response)
  end

  def toppings_on_existing_pizza pizza_id
    response = self.class.get("/pizzas/#{pizza_id}/toppings")
    readable_json(response)
  end

  private

	  def readable_json response
	  	JSON.parse(response.body)
	  end
end