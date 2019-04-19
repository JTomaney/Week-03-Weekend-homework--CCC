require("pry")
require_relative("models/film.rb")
require_relative("models/customer.rb")
require_relative("models/ticket.rb")

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new({"title" => "The Raid", "price" => "7"})
film1.save()
film2 = Film.new({"title" => "Spaceballs", "price" => "5"})
film2.save()
film3 = Film.new({"title" => "Logan Lucky", "price" => "8"})
film3.save()

customer1 = Customer.new({"name" => "Jon", "funds" => "40"})
customer1.save()
customer2 = Customer.new({"name" => "Tom", "funds" => "60"})
customer2.save()
customer3 = Customer.new({"name" => "Jordan", "funds" => "55"})
customer3.save()

ticket1 = Ticket.new({"film_id" => film1.id, "customer_id" => customer1.id})
ticket1.save()
ticket2 = Ticket.new({"film_id" => film2.id, "customer_id" => customer2.id})
ticket2.save()
ticket3 = Ticket.new({"film_id" => film1.id, "customer_id" => customer2.id})
ticket3.save()

binding.pry
nil
