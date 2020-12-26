require "sinatra"
require "sinatra/json"
require "sinatra/activerecord"
require "rack/contrib"
require "zeitwerk"
require "dotenv/load"
require "graphql"

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/app/models")

loader.do_not_eager_load("#{Dir.pwd}/app/services")
loader.collapse("#{__dir__}/app/types")
loader.collapse("#{__dir__}/app/mutations")
loader.collapse("#{__dir__}/app/queries")
loader.collapse("#{__dir__}/app/services")
loader.push_dir("#{Dir.pwd}/app/graphql")
loader.setup

class SoulsApi < Sinatra::Base
  set :database_file, "config/database.yml"
  use Rack::JSONBodyParser

  get "/" do
    message = { success: true, message: "hello" }
    json message
  end

  post "/graphql" do
    token = request.env["HTTP_AUTHORIZATION"]
    context = {
      token: token
    }
    result = SoulsApiSchema.execute(
      params[:query],
      variables: params[:variables],
      context: context
    )
    json result
  end
end
