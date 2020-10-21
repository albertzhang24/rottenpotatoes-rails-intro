class Movie < ActiveRecord::Base
  def self.all_ratings()
    ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings_list)
    result = nil
    if ratings_list.length == 0
      return Movie.all
    end 
    if !ratings_list.nil?
      result = Movie.where(rating: ratings_list)
    end 
    result 
  end 
end
