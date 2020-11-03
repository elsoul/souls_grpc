namespace :grpc do
  $LOAD_PATH << "#{Dir.pwd}/app/services"
  Dir[File.expand_path "./app/services/*.rb"].sort.each do |file|
    require file
  end
  desc "proto initialize"
  task proto: :environment do
    system "grpc_tools_ruby_protoc -I ./protos --ruby_out=./app/services --grpc_out=./app/services ./protos/helloworld.proto"
    puts "created proto files at `./app/services` !"
  end

  desc "gRPC test"
  task test: :environment do
    def grpc_test name: "world"
      user = name
      host = if Rails.env.production?
               "xds:///helloworld-gke:8000"
             else
               "localhost:50051"
             end
      stub = Helloworld::Greeter::Stub.new(host, :this_channel_is_insecure)
      begin
        message = stub.say_hello(Helloworld::HelloRequest.new(name: user)).message
        p "Greeting: #{message}"
        message = stub.say_hello_again(Helloworld::HelloRequest.new(name: user)).message
        p "Greeting: #{message}"
        { response: message.to_s }
      rescue GRPC::BadStatus => e
        abort "ERROR: #{e.message}"
      end
    end
    grpc_test name: "test! hey!"
  end
end
