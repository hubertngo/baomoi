class Article < ActiveRecord::Base
  attr_accessible :content, :desc, :image, :title
  belongs_to :category
end
