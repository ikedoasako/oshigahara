class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      #カラムを追加
      t.integer :post_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
