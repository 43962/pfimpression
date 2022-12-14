class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :customer_id
      t.integer :category_id
      t.integer :height
      t.integer :weight
      t.string :item_name
      t.text :review
      t.boolean :is_draft, default: false
      t.timestamps
    end
  end
end
