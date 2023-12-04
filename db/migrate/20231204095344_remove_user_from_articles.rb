class RemoveUserFromArticles < ActiveRecord::Migration[7.1]
  def change
    remove_column :articles, :user, :string
  end
end
