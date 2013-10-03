class Movie < ActiveRecord::Base
  scope :sort_with_params, lambda{|column, sort|
    sql_sort = sort.to_i==0 ? 'desc' : 'asc'
    order(sanitize_sql(column)+' '+sanitize_sql(sql_sort))}

  scope :filter_by_ratings, lambda { |ratings|
    sanitized_ratings = ratings.map{|v| sanitize_sql(v)}
    where(:rating => sanitized_ratings) }
end
