class AddUserToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :user, :string
  end
end
