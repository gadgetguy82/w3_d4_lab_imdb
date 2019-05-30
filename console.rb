require_relative("models/casting.rb")
require_relative("models/movie.rb")
require_relative("models/star.rb")
require("pry")

star1 = Star.new({"first_name" => "Robert", "last_name" => "Clooney"})
star1.save()
star2 = Star.new({"first_name" => "Simon", "last_name" => "Eastwood"})
star2.save()
star3 = Star.new({"first_name" => "Boris", "last_name" => "Becker"})
star3.save()

movie1 = Movie.new({"title" => "Jurassic Park", "genre" => "Action Adventure"})
movie1.save()
movie2 = Movie.new({"title" => "The Matrix", "genre" => "Sci Fi"})
movie2.save()

casting1 = Casting.new({"movie_id" => movie1.id, "star_id" => star1.id, "fee" => 100})
casting1.save()
casting2 = Casting.new({"movie_id" => movie1.id, "star_id" => star2.id, "fee" => 70})
casting2.save()
casting3 = Casting.new({"movie_id" => movie1.id, "star_id" => star3.id, "fee" => 50})
casting3.save()
casting4 = Casting.new({"movie_id" => movie2.id, "star_id" => star1.id, "fee" => 100})
casting4.save()
casting5 = Casting.new({"movie_id" => movie2.id, "star_id" => star3.id, "fee" => 50})
casting5.save()

star2.last_name = "Stallone"
star2.update()
movie1.title = "Jurassic Park II"
movie1.update()
casting1.fee = 10000000
casting1.update()

# CREATE TABLE castings
# (
#   movie_id INT4,
#   star_id INT4,
#   fee INT4,
#   id SERIAL4 PRIMARY KEY
# );
binding.pry
nil
