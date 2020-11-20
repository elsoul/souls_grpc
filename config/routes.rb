Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphqlPlaygroundRails::Engine, at: "/graphql/playground", graphql_path: "/v2/graphql"
  end
  root "application#ok"
  post "/v2/graphql", to: "graphql#execute"
end
