require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"].to_i
    @customer_id = options["customer_id"].to_i
  end

  def save()
    sql = "INSERT INTO tickets (film_id, customer_id) VALUES ($1, $2) RETURNING id;"
    values = [@film_id, @customer_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"]
  end

  def self.all_tickets()
    sql = "SELECT tickets.* FROM tickets;"
    ticket_list = SqlRunner.run(sql)
    ticket_objects = ticket_list.map { |ticket| Ticket.new(ticket) }
    return ticket_objects
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

end
