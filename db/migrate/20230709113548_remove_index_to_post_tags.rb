class RemoveIndexToPostTags < ActiveRecord::Migration[6.1]
  def change
    remove_index :post_tags, name: "index_post_tags_on_post_id_and_tag_id"
  end
end
