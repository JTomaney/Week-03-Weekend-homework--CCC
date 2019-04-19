require('pry')
require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ( $1, $2) RETURNING id;"
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"]
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customer_list = SqlRunner.run(sql, values)
    customer_objects = customer_list.map { |customer| Customer.new(customer)  }
    return customer_objects
  end

  def total_customers()
    customer_objects = self.customers()
    return customer_objects.length()
  end

  def self.all_films()
    sql = "SELECT films.* FROM films;"
    film_list = SqlRunner.run(sql)
    film_objects = film_list.map { |film| Film.new(film) }
    return film_objects
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

end
