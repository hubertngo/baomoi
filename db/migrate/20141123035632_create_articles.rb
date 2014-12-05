class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :title
      t.text :content
      t.string :image
      t.text :desc
      t.references :category , index: true 
      t.references :tobao , index: true 
      t.timestamps
    end
  end
end
