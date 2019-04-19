require('pry')
require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id, :title, :price

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
