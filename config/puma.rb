workers Integer(ENV['WEB_CONCURRENCY'] || 2)
# The `threads` method setting takes two numbers: a minimum and maximum.	threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count


preload_app!

 # Specifies the `port` that Puma will listen on to receive requests; default is 3000.
rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
   ActiveRecord::Base.establish_connection
end
