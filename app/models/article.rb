class Article < ActiveRecord::Base
  attr_accessible :content, :desc, :image, :title, :tobao
  belongs_to :category
  belongs_to :tobao
end
