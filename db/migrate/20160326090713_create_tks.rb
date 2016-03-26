class CreateTks < ActiveRecord::Migration
  def change
    create_table :tks do |t|
      t.string :title
      t.string :content

      t.timestamps null: false
    end
  end
end
