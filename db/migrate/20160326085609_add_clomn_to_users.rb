class AddClomnToUsers < ActiveRecord::Migration
  def change
  	add_cloumn :users, :content, :string
  end
end
