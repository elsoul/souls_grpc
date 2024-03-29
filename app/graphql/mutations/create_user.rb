module Mutations
  class CreateUser < BaseMutation
    argument :id, String, required: true
    argument :username, String, required: true
    argument :email, String, required: true
    argument :screen_name, String, required: true
    argument :icon_url, String, required: false
    argument :birthday, String, required: false
    argument :lang, String, required: false
    argument :total_articles, String, required: false
    argument :total_tweets, String, required: false
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false

    field :user, Types::UserType, null: false

    def resolve **args
      # host = blog_host
      # stub = Souls::Blog::Stub.new(host, :this_channel_is_insecure)
      # data = stub.create_user(user)
      user = User.create!(args)
      { user: user }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
