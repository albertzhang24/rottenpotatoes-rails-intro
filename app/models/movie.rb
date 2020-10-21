class Movie < ActiveRecord::Base
  def self.all_ratings()
    ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings_list)
    if ratings_list.length == 0 or ratings_list.nil?
      return all
    end 
    if !ratings_list.nil?
      return Movie.where(rating: ratings_list)
    end 
  end 
  
  def self.sort_title(ratings_list)
#     byebug
    if ratings_list.length == 0
      return Movie.order(:title)
    end
    Movie.where(rating: ratings_list).order(:title)
  end 
  
  def self.sort_rd(ratings_list)
#     byebug
    if ratings_list.length == 0
      return Movie.order(:release_date)
    end
    Movie.where(rating: ratings_list).order(:release_date)
  end 
end
