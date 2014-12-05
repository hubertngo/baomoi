class AddTobaoToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :tobao_id, :integer, references: :tobaos
  end
end
