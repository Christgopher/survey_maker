require("sinatra")
require("sinatra/reloader")
require "sinatra/activerecord"
require("./lib/division")
require("./lib/employee")
require("./lib/project")

also_reload("lib/**/*.rb")
require("pg")
