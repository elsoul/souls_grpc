module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Queries::User
    field :users, resolver: Queries::Users
  end
end
