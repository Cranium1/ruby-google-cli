require 'bundler/setup'
Bundler.require(:default, :development)
$: << '.'

puts Dir.pwd

Dir['app/models/*.rb'].each {|f| require f}
Dir['app/data_fetchers/*.rb'].each {|f| require f}
Dir['app/runners/*.rb'].each {|f| require f}
Dir['app/util/*.rb'].each {|f| require f}


require 'open-uri'
require 'uri'
require 'json'
require 'io/console'
require 'pry'
require 'colorize'
require 'optparse'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
