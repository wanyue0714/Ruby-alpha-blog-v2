class Article < ActiveRecord::Base
  # verify data before hit the database
  validates :title, presence: true, length: { minimum: 3, maximum: 50}
  validates :description, presence: true, length: { minimum: 10, maximum: 300}
end