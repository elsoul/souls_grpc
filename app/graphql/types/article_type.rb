module Types
  class ArticleType < Types::BaseObject
    description "Artice"
    field :id, ID, null: false
    field :user_id, String, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :thumnail_url, String, null: false
    field :public_date, GraphQL::Types::ISO8601DateTime, null: false
    field :article_category_id, Integer, null: false
    field :is_public, Boolean, null: true
    field :tag, [String], null: true
    field :has_series, Boolean, null: true
    field :series_id, Integer, null: true
    field :episode_num, Integer, null: true
    field :user, Types::UserType, null: true
    field :article_category, Types::ArticleCategoryType, null: true
    field :created_at, String, null: true
    field :updated_at, String, null: true
  end
end
