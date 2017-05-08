#!/usr/bin/env ruby

require 'pry'

# this is a simple routine to create the basic directories for a Sinatra
# application,
project_name, user_path = ARGV
project_name = project_name || "myWeb"

#project_creator_path = ENV["PROJECT_CREATOR_PATH"]
project_creator_path = File.expand_path($0).gsub('/newp', '')

base_path = user_path || File.expand_path(".")
path = "#{base_path}/#{project_name}"

directories = [
  "#{path}/views",
  "#{path}/config",
  "#{path}/db",
  "#{path}/models",
  "#{path}/public",
  "#{path}/public/js",
  "#{path}/public/js/vendor",
  "#{path}/public/css",
  "#{path}/public/css/vendor"
]

# If you need to use more files just add them here in the hash
# like key: "#{path}/<name of the file/" => ["<lines that you want in the file>"]
files = {
  # config.ru is required by Heroku to deploy Sinatra apps
  "#{path}/config.ru" => [
    "require './app'",
    "run Sinatra::Application"
  ],
  # rakefile.rb to create migrations and have the rake functionality
  "#{path}/rakefile.rb" => [
    "require './app'",
    "require 'sinatra/activerecord/rake'"
  ],
  # README file put some comments about your new application
  "#{path}/README.md" => [
    "###{project_name.capitalize}\n\n",
    "Your project description"
  ],
  # SQL schema file to create the tables in your database
  # "#{path}/schema.sql" => [
  #   "-- If you want to run this schema repeatedly you'll need to drop",
  #   "-- the table before re-creating it. Note that you'll lose any",
  #   "-- data if you drop and add a table:\n\n",
  #   "-- DROP TABLE IF EXISTS <table name>;\n\n",
  #   "-- Define your schema here:\n\n",
  #   "-- CREATE TABLE <table name> (",
  #   "--   id serial PRIMARY KEY,",
  #   "--   <column name> <type of data> NOT NULL",
  #   "-- );",
  #   ],
  # .gitignore file to hide your private information like API keys
  "#{path}/.gitignore" => [
    ".env",
    ".swp"
  ],
  # Gemfile add all your gems to share with your app
  "#{path}/Gemfile" => [
    "#List the gems required for your application",
    "source 'https://rubygems.org/'\n\n",
    "ruby '#{RUBY_VERSION}'\n\n",
    "gem 'sinatra'",
    "gem 'pry'",
    "gem 'pg'",
    "gem 'activerecord'",
    "gem 'sinatra-activerecord'",
    "gem 'rake'"
  ],
  # The heart of your app, functions and controllers
  "#{path}/app.rb" => [
    "require 'sinatra'",
    "require 'sinatra/activerecord'",
    "#debugging tool",
    "require 'pry'\n\n",
    # "#Uncomment this line to use 'pg' to connect to your DB",
    # "#require 'pg'\n\n",
    # "#############",
    # "# FUNCTIONS #",
    # "#############\n\n",
    # "#connection to your database using postgreSQL",
    # "#def db_connection",
    # "#  begin",
    # '#    connection = PG.connect(dbname: "<database name>")',
    # "#    yield(connection)",
    # "#  ensure",
    # "#    connection.close",
    # "#  end",
    # "#end\n\n",
    # "#request the data from your table",
    # "#def get_data",
    # "#  <your variable> = db_connection do |conn|",
    # '#    conn.exec("SELECT <rows names> FROM <table name>")',
    # "#  end",
    # "#end\n\n",
    "###############",
    "# CONTROLLERS #",
    "#  & ROUTES   #",
    "###############\n\n",
    "get '/' do",
    "  redirect '/home'",
    "end\n\n",
    "get '/home' do",
    "  erb :home",
    "end"
  ],
  # file to setup the database
  "#{path}/config/database.yml.example" => [
    "# Configure the database used when in the development environment",
    "development:",
    "  adapter: postgresql",
    "  encoding: unicode",
    "  database: #{project_name.gsub(/\W/, '_')}_development",
    "  pool: 5",
    "  username:",
    "  password:",
    "# Configure the database used when in the test environment",
    "test:",
    "  adapter: postgresql",
    "  encoding: unicode",
    "  database: #{project_name.gsub(/\W/, '_')}_test",
    "  pool: 5",
    "  username:",
    "  password:",
    "# Configure the database used when in the production environment",
    "production:",
    "  adapter: postgresql",
    "  encoding: unicode",
    "  database: #{project_name.gsub(/\W/, '_')}_production",
    "  pool: 5",
    "  username:",
    "  password:"
  ],
  # Your own JavaScript file
  "#{path}/public/js/#{project_name}.js" => [
    "// Add your JS code"
  ],
  # Your own CSS file
  "#{path}/public/css/#{project_name}.css" =>[
    "/* Add some style! */"
  ],
  # The layout file already linked to the CSS files and JS
  "#{path}/views/layout.erb" => [
    "<!DOCTYPE html>",
    "<html lang='en'>",
    "<head>",
    "    <meta charset='UTF-8'>",
    "    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'/>",
    "    <title>#{project_name}</title>",
    "    <link type='text/css' rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>",
    "    <link type='text/css' rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/bulma/0.4.1/css/bulma.css' media='screen,projection'>",
    "    <link type='text/css' rel='stylesheet' href='/css/#{project_name}.css'>",
    "</head>",
    "<body>",
    "    <%= yield %>\n\n",
    "    <script type='text/javascript' src='https://code.jquery.com/jquery-3.2.1.slim.min.js'></script>",
    "</body>",
    "</html>"
  ],
  "#{path}/views/home.erb" => [
    "<h3>#{project_name} Home</h3>\n\n"
  ]
}

#vendor_files = [
#  "materialize.min.css",
#  "materialize.min.js"
#  # "normalize.css",
#  # "jquery-2.1.3.min.js"
#]

directories.each { |path_dir| system 'mkdir', '-p', path_dir }

files.keys.each { |path_file| system 'touch', path_file }

files.each do |file_path, info|
  File.open(file_path, 'w') do |file|
    info.each { |line| file.puts(line) }
  end
end

#vendor_files.each do |vfile_name|
#  extension = vfile_name.scan(/\.(\w{2,3})\z/i).join
#  system 'cp', "#{project_creator_path}/public/#{vfile_name}", "#{path}/public/#{extension}/vendor/"
#end

success = "| Your #{project_name} project was successfully generated! |"

if File.directory?(path)
  puts "#{'-'*success.size}\n#{success}\n#{'-'*success.size}"
else
  puts "#{'-'*30}\n| Something went wrong, ups! |\n#{'-'*30}"
end
