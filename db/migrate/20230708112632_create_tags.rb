class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      #カラムの追加
      t.string :name,null: false
      
      t.timestamps
    end
  end
end
