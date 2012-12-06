$:.unshift File.expand_path('../', __FILE__)

require 'rubygems'
require 'sinatra'
require './app'

require 'dalli'
require 'rack-cache'

if memcache_servers = ENV["MEMCACHE_SERVERS"]
  use Rack::Cache,
    verbose: true,
    metastore:   "memcached://#{memcache_servers}",
    entitystore: "memcached://#{memcache_servers}"
end

run Sinatra::Application
