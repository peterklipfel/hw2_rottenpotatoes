class Movie < ActiveRecord::Base
  scope :sort_with_params, lambda{|column, order|
    order(sanitize_sql(column)+' '+sanitize_sql(order))}

  scope :filter_by_ratings, lambda { |ratings|
    sanitized_ratings = ratings.map{|v| sanitize_sql(v)}
    where(:rating => sanitized_ratings) }
end
