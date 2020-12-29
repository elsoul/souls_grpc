class ArticleCategory
  include Mongoid::Document
  has_many :article, dependent: :destroy
  validates :name, uniqueness: true
end
