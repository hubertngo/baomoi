class Post < ActiveRecord::Base
  attr_accessible :content, :title, :image, :desc
  belongs_to :category
end
