require("pry")
require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ( $1, $2) RETURNING id;"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"]
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    film_list = SqlRunner.run(sql, values)
    film_objects = film_list.map { |film| Film.new(film)  }
    return film_objects
  end

  def total_tickets()
    film_objects = self.films()
    return film_objects.length()
  end

  def purchase_ticket(film)
    @funds -= film.price()
    ticket = Ticket.new({"film_id" => film.id, "customer_id" => @id})
    ticket.save()
  end

  def self.all_customers()
    sql = "SELECT customers.* FROM customers;"
    customer_list = SqlRunner.run(sql)
    customer_objects = customer_list.map { |customer| Customer.new(customer) }
    return customer_objects
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

end
