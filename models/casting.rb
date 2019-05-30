require_relative("../db/sql_runner.rb")
class Casting

  attr_accessor :fee
  attr_reader :movie_id, :star_id, :id

  def initialize(options)
    @movie_id = options["movie_id"]
    @star_id = options["star_id"]
    @fee = options["fee"]
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO castings (
    movie_id,
    star_id,
    fee
    ) VALUES (
      $1, $2, $3
      ) RETURNING id"
      values = [@movie_id, @star_id, @fee]
      casting = SqlRunner.run( sql, values ).first
      @id = casting["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM castings"
    castings = SqlRunner.run( sql )
    result = castings.map { |casting| Casting.new( casting )}
    return result
  end

  def update()
    sql = "UPDATE castings SET (
    movie_id,
    star_id,
    fee
    ) =
    (
      $1, $2, $3
      )
      WHERE id = $4"
      values = [@movie_id, @star_id, @fee, @id]
      SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    values = []
    SqlRunner.run( sql, values )
  end

end
