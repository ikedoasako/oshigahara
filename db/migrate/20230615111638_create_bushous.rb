class CreateBushous < ActiveRecord::Migration[6.1]
  def change
    create_table :bushous do |t|

      #カラムの追加
      t.string :bushou_name, null: false
      t.text :explanation, null:false
      #集計用のカラム追加
      t.integer :tally
      t.timestamps
    end
  end
end
