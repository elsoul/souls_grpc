require "./app"
require "graphql_playground"

map "/playground" do
  use GraphQLPlayground, endpoint: "/graphql"
end

run SoulsApi
