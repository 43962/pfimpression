#管理者用ログイン情報
Admin.create!(
    email: 'admin@admin.com',
    password: '123456',
)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テストデータ挿入
customers = Customer.create!(
  [
    {email: 'olivia@test.com', name: 'Olivia', password: 'password'},
    {email: 'james@test.com', name: 'James', password: 'password'},
    {email: 'lucas@test.com', name: 'Lucas', password: 'password'}
  ]
)

categories = Category.create!(
  [
    {name: 'outer'},
    {name: 'dress'},
    {name: 'tops'},
    {name: 'bottoms'},
  ]
)

Review.create!(
  [
    {item_name: 'オーバーコート', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), height: '150', weight: '40', category_id: categories[0].id, is_draft: false, review: 'オーバーサイズでも丈が短めで低身長でも着やすい。', customer_id: customers[0].id },
    {item_name: 'キャミワンピース', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), height: '160', weight: '50', category_id: categories[1].id, is_draft: false, review: 'ウエスト周りが大きいのでインナーが必須', customer_id: customers[1].id },
    {item_name: 'ブラウス', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), height: '170', weight: '60', category_id: categories[2].id, is_draft: false, review: '袖のボリュームが二の腕や肩をカバーしてくれるので挑戦しやすい！', customer_id: customers[2].id }
  ]
)

