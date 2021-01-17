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

# NoSQL Conf
YAML.safe_load(ERB.new(File.new("./config/mongoid.yml").read).result)

## SQL Conf
# db_conf = YAML.safe_load(ERB.new(File.read("./config/database.yml")).result, [], [], true)
# ActiveRecord::Base.establish_connection(db_conf[ENV["RACK_ENV"]])

Dir[File.expand_path "#{Dir.pwd}/app/services/*.rb"].sort.each { |file| require file }

loader = Zeitwerk::Loader.new
loader.push_dir("#{Dir.pwd}/app/models")

loader.collapse("#{__dir__}/app/types")
loader.collapse("#{__dir__}/app/mutations")
loader.collapse("#{__dir__}/app/queries")
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
