class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :post, index: true

      t.timestamps
     #adding columns and indexes for user_id
      add_column :comments, :posts, :user_id, :integer
      add_index :comments, :user_id
    end
  end

end
