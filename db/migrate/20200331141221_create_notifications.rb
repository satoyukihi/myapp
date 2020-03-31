class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :visitor, foreign_key:{ to_table: :users }, null: false
      t.references :visited, foreign_key:{ to_table: :users }, null: false
      t.references :micropost, foregin_key:true
      t.references :comment, foregin_key:true
      t.string :action, null: false
      t.boolean :checked, null: false

      t.timestamps
    end
  end
end
