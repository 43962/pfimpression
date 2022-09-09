class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :customer_id
      t.integer :category_id
      t.integer :height
      t.integer :weight
      t.string :item_name
      t.text :review
      t.boolean :is_draft
      t.timestamps
    end
  end
end
