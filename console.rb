require("pry")
require_relative("models/film.rb")
require_relative("models/customer.rb")
require_relative("models/ticket.rb")

film1 = Film.new({"title" => "The Raid", "price" => "7"})
film1.save()

customer1 = Customer.new({"name" => "Jon", "funds" => "40"})
customer1.save()

ticket1 = Ticket.new({"film_id" => film1.id, "customer_id" => customer1.id})
ticket1.save()





binding.pry
nil
