class Movie < ActiveRecord::Base
  def self.all_ratings()
    ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings_list)
    if ratings_list.length == 0
      return Movie.all
    end 
    if !ratings_list.nil?
      return Movie.where(rating: ratings_list)
    end 
  end 
  
  def self.sort_title()
    result = Movie.order(:title)
    movie_classes = "hilite p-3 mb-2 bg-warning text-dark"
    return movie_classes, result
  end 
  
  def self.sort_rd()
    result = Movie.order(:release_date)
    rd_classes = "hilite p-3 mb-2 bg-warning text-dark"
    return rd_classes, result 
  end 
end
