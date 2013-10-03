class Movie < ActiveRecord::Base
  scope :sort, lambda{|column, order|
    order(sanitize_sql(column)+' '+sanitize_sql(order))}
end
