module Mutations
  class HelloWorld < BaseMutation
    field :response, String, null: false
    argument :name, String, required: false
    argument :host, String, required: false

    def resolve name: "world", host: ENV["GRPC_SERVER_URL"]
      user = !ARGV.empty? ? ARGV[0] : name
      stub = Souls::Blog::Stub.new(host, :this_channel_is_insecure)
      begin
        message = stub.say_hello(Souls::HelloRequest.new(name: user)).message
        p "Greeting: #{message}"
        message = stub.say_hello_again(Souls::HelloRequest.new(name: user)).message
        p "Greeting: #{message}"
        { response: message.to_s }
      rescue GRPC::BadStatus => e
        abort "ERROR: #{e.message}"
      end
    end
  end
end
