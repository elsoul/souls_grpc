module Mutations

  class CreateArticle < BaseMutation
    field :article, Types::ArticleType, null: false
    field :error, String, null: false

    argument :user_id, String, required: false
    argument :title, String, required: true
    argument :body, String, required: true
    argument :thumnail_url, String, required: true
    argument :public_date, String, required: true
    argument :is_public, Boolean, required: false
    argument :tag, [String], required: false
    argument :token, String, required: false

    def resolve **args
      host = blog_host
      stub = Souls::Blog::Stub.new(host, :this_channel_is_insecure)
      begin
        data = stub.create_article(Souls::Article.new(args))
        timestamp = Date.parse(Time.at(Time.now.seconds, Time.now.nanos).to_s).strftime("%F %H:%M:%S")
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
        puts data.article.created_at.seconds
        puts data.article.created_at.nanos
        puts timestamp
        puts article.to_json
        { article: article }
      rescue StandardError => e
        { error: e.to_s }
      rescue GRPC::BadStatus => e
        abort "ERROR: #{e.message}"
      end
    end
  end
end
