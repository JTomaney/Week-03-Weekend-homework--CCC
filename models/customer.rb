require("pry")
require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id, :name, :funds

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
