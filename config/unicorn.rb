worker_processes Integer(ENV["WEB_CONCURRENCY"] || 2)
timeout 150
preload_app true

listen "/tmp/unicorn.sock"
pid "/tmp/unicorn.pid"
