require_relative "../config/environment"

data = File.read("config/keys.json")
config = JSON.parse(data)
options = Option.new.options

Application.new(config, options)