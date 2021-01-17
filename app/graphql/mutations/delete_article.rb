module Mutations
  class DeleteArticle < BaseMutation
    field :article, Types::ArticleType, null: false
    argument :id, Integer, required: true

    def resolve id:
      host = blog_host
      stub = Souls::Blog::Stub.new(host, :this_channel_is_insecure)
      data = stub.delete_article(id)
      article = Article.new(
        id: data.article.id,
        user_id: data.article.user_id,
        title: data.article.title,
        body: data.article.body,
        thumnail_url: data.article.thumnail_url,
        public_date: data.article.public_date,
        is_public: data.article.is_public,
        tag: data.article.tag.to_a,
        created_at: data.created_at.to_s,
        updated_at: data.updated_at.to_s
      )
      { article: article }
    rescue StandardError => e
      puts e.error.inspect
    end
  end
end
