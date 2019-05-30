require_relative("../db/sql_runner.rb")
require_relative("star.rb")
require_relative("casting.rb")

class Movie
  attr_accessor :title, :genre, :budget
  attr_reader :id

  def initialize(options)
    @title = options["title"]
    @genre = options["genre"]
    @budget = options["budget"]
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO movies (
    title,
    genre,
    budget
    ) VALUES (
      $1, $2, $3
      ) RETURNING id"
      values = [@title, @genre, @budget]
      movie = SqlRunner.run( sql, values).first
      @id = movie["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run( sql )
    result = movies.map { |movie| Movie.new( movie )}
    return result
  end

  def update()
    sql = "UPDATE movies SET (
    title,
    genre,
    budget
    ) =
    (
      $1, $2, $3
      )
      WHERE id = $4"
      values = [@title, @genre, @budget, @id]
      SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    values = []
    SqlRunner.run( sql, values )
  end

  #Gets stars related to movie selcted.
  def stars()
    sql = "SELECT stars.* FROM stars INNER JOIN castings ON castings.star_id = stars.id WHERE movie_id = $1"
    values = [@id]
    stars = SqlRunner.run( sql, values)
    return stars.map {|star|  Star.new(star)}
  end

  def remaining_budget()

    sql = "SELECT castings.* FROM castings INNER JOIN stars ON castings.star_id = stars.id WHERE movie_id = $1"
    values = [@id]
    castings = SqlRunner.run(sql, values)
    castings = castings.map{|casting| Casting.new(casting)}
    stars_fees = castings.map { |casting| casting.fee.to_i }
    total_fees = stars_fees.reduce {|running_total, number| running_total + number}
    remaining_movie_budget = @budget - total_fees
    return remaining_movie_budget
  end


end
