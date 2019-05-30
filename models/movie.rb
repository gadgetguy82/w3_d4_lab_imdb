require_relative("../db/sql_runner.rb")
class Movie
  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @title = options["title"]
    @genre = options["genre"]
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO movies (
    title,
    genre
    ) VALUES (
      $1,$2
      ) RETURNING id"
      values = [@title, @genre]
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
    genre
    ) =
    (
      $1, $2
      )
      WHERE id = $3"
      values = [@title, @genre, @id]
      SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    values = []
    SqlRunner.run( sql, values )
  end


end
