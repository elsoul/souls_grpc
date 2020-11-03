Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphqlPlaygroundRails::Engine, at: "/graphql/playground", graphql_path: "/v2/graphql"
  end
  root "application#ok"
  get "/v1/db_test", to: "application#db_test"
  post "/v2/graphql", to: "graphql#execute"
end
