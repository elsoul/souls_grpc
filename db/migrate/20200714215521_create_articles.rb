class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, type: :string
      t.string :title, null: false
      t.text :body, null: false
      t.string :thumnail_url, null: false
      t.datetime :public_date, null: false
      t.references :article_category, null: false, foreign_key: true
      t.boolean :is_public, default: false
      t.text :tag, array: true, default: []
      t.boolean :has_series, default: false
      t.integer :series_id, default: 0
      t.integer :episode_num, default: 0

      t.timestamps
    end
    add_index :articles, :tag
    add_index :articles, :has_series
    add_index :articles, :is_public
  end
end
