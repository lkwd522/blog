class RemoveSlugFromArticles < ActiveRecord::Migration[7.0]
  def change
  remove_column :articles, :slug
 end
end
