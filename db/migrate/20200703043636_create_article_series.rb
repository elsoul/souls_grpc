class CreateArticleSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :article_series do |t|
      t.string :name, null: false
      t.string :category
      t.integer :total_episodes, default: 0
      t.string :description

      t.timestamps
    end
    add_index :article_series, :name
    add_index :article_series, :category
  end
end
