class CreateTableFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.float :price
      t.string :imgurl
      t.string :desc
    end
  end
end
