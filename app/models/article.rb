class Article
  include Mongoid::Document
  ## Relations
  # belongs_to :user
  validates_presence_of :title
  validates_uniqueness_of :title

  field :user_id, type: String
  field :title, type: String
  field :body, type: String
  field :thumnail_url, type: String
  field :public_date, type: DateTime
  field :is_public, type: Mongoid::Boolean
  field :tag, type: Array
  field :token, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime
end
