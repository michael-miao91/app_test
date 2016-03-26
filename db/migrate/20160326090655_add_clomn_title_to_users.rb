class AddClomnTitleToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :zzm_test, :string
  end
end
