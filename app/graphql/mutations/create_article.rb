module Mutations
  require "./app/services/souls"

  class CreateArticle < BaseMutation
    field :article, Types::ArticleType, null: false
    field :error, String, null: false

    argument :user_id, String, required: false
    argument :title, String, required: true
    argument :body, String, required: true
    argument :thumnail_url, String, required: true
    argument :public_date, Integer, required: true
    argument :is_public, Boolean, required: false
    argument :tag, [String], required: false
    argument :created_at, Integer, required: false
    argument :updated_at, Integer, required: false
    argument :token, String, required: false

    def resolve **args
      host = blog_host
      stub = Souls::Blog::Stub.new(host, :this_channel_is_insecure)
      begin
        data = stub.create_article(Souls::Article.new(args))
        article = Article.new(
          id: data.article.id,
          user_id: data.article.user_id,
          title: data.article.title,
          body: data.article.body,
          thumnail_url: data.article.thumnail_url,
          public_date: data.article.public_date,
          tag: data.article.tag.to_a,
          created_at: data.article.created_at,
          updated_at: data.article.updated_at
        )
        puts data
        puts data.to_json
        puts article.to_json
        { article: article }
      rescue GRPC::BadStatus => e
        abort "ERROR: #{e.message}"
      end
    end
  end
end
