require "sinatra"
require "sinatra/json"
require "sinatra-env"
require "mongoid"
require "rack/contrib"
require "zeitwerk"
require "dotenv/load"
require "firebase_id_token"
require "./config/initializers/firebase_id_token"
require "graphql"
require "grpc"
require "erb"

YAML.safe_load(ERB.new(File.new("./config/mongoid.yml").read).result)

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/app/models")

loader.collapse("#{__dir__}/app/types")
loader.collapse("#{__dir__}/app/mutations")
loader.collapse("#{__dir__}/app/queries")
loader.push_dir("#{__dir__}/app/services")
loader.push_dir("#{Dir.pwd}/app/graphql")
loader.setup

class SoulsApi < Sinatra::Base
  use Rack::JSONBodyParser

  get "/" do
    message = { success: true, message: "SOULs Running!" }
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
