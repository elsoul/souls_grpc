# Generated by the SOULs protocol buffer compiler.  DO NOT EDIT!
# Source: blog.proto for package 'Souls'

module Souls
  module Blog
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'Souls.Blog'

      # Sends a greeting
      rpc :SayHello, ::Souls::HelloRequest, ::Souls::HelloReply
      # Sends another greeting
      rpc :SayHelloAgain, ::Souls::HelloRequest, ::Souls::HelloReply
      # Blog Service Sample
      rpc :GetArticle, ::Souls::GetArticlRequest, ::Souls::GetArticleReply
      rpc :GetArticles, ::Souls::GetArticlesRequest, stream(::Souls::Article)
      rpc :CreateArticle, ::Souls::Article, ::Souls::CreateArticleReply
      rpc :UpdateArticles, stream(::Souls::Article), ::Souls::UpdateArticlesReply
      rpc :DeleteArticle, ::Souls::DeleteArticlRequest, ::Souls::DeleteArticleReply
      rpc :CreateArticlesInStream, stream(::Souls::Article), stream(::Souls::Article)
    end

    Stub = Service.rpc_stub_class
  end
end
