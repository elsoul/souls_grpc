# Ruby GraphQL API Server with gRPC
Ruby GraphQL API Server with gRPC Boilerplate

<p align="center">

  <a aria-label="Ruby logo" href="https://el-soul.com">
    <img src="https://badgen.net/badge/icon/Made%20by%20ELSOUL?icon=ruby&label&color=black&labelColor=black">
  </a>
  <br/>
</p>

## Installation

git clone

```
  git clone git@github.com:elsoul/souls_api.git
  cd souls_api
  bundle install
```



## Usage

Check Rakefile to see what command is available

```ruby
rake -T
```


# Run Server on local

```ruby
bundle exec puma -p 3000 -e development
```

You can see GraphQL Playground here;

`localhost:3000/playground`

# Run Server on production
※You need redis-server for production.

```ruby
foreman start
```


# Run Server with Docker

```ruby
souls p run_test
```

# Run Client to check response

```ruby
  rake run_client
```

Then you will get response below;

```
"Greeting: Hello world"
"Greeting: Hello again, world"
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org/gems/souls_api).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elsoul/souls_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [Apache-2.0 License](https://www.apache.org/licenses/LICENSE-2.0).

## Code of Conduct

Everyone interacting in the HotelPrice project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elsoul/souls_api/blob/master/CODE_OF_CONDUCT.md).
