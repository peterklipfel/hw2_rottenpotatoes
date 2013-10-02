class Movie < ActiveRecord::Base
  scope :sort, lambda{|column='title', order='desc'| order(sanitize_sql(column)+' '+sanitize_sql(order))}
end
