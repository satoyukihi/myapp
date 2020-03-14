class CreateTagRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_relationships do |t|
      t.references :micropost, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
      add_index :tag_relationships, [:micropost_id,:tag_id],unique: true
  end
end
