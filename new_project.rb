# this is a simple routine to create the basic directories for a Sinatra
# application,
ARGV.empty? ? project_name = "new-project" : project_name = ARGV.join

path = "#{File.expand_path(".").split('/')[0..-2].join('/')}/#{project_name}"

directories = [
  "#{path}/views",
  "#{path}/public",
  "#{path}/public/js",
  "#{path}/public/js/vendor",
  "#{path}/public/css",
  "#{path}/public/css/vendor"
  ]

# If you need to use more files just added here in the hash
# like key: "#{path}/<name of the file/" => ["<lines that you want in the file>"]
files = {
 # README file put some comments about your new application
  "#{path}/README.md" => [
    "###{project_name.capitalize}\n\n",
    "some description of your project"
    ],
 # SQL schema file to create the tables in your database
  "#{path}/schema.sql" => [
    "-- If you want to run this schema repeatedly you'll need to drop",
    "-- the table before re-creating it. Note that you'll lose any",
    "-- data if you drop and add a table:\n\n",
    "-- DROP TABLE IF EXISTS <table name>;\n\n",
    "-- Define your schema here:\n\n",
    "-- CREATE TABLE <table name> (",
    "--   id serial PRIMARY KEY,",
    "--   <column name> <type of data> NOT NULL",
    "-- );",
    ],
 # .gitignore file to hide your private information like API keys
  "#{path}/.gitignore" => [
    ".env"
    ],
 # Gemfile add all your gems to share with your app
  "#{path}/Gemfile" => [
    "#share all the gems that your awesome app needs",
    "source 'https://rubygems.org/'\n\n",
    "gem 'sinatra'",
    "gem 'pg'"
    ],
 # The heart of your app, functions and controllers
  "#{path}/server.rb" => [
    "require 'sinatra'",
    "require 'erb'",
    "#this is dedicated to Spencer, great EE who show us the power of pry!",
    "require 'pry'",
    "#Uncomment this line to use 'pg' to connect to your DB",
    "#require 'pg'\n\n",
    "#############",
    "# FUNCTIONS #",
    "#############\n\n",
    "#connection to your database using postgreSQL",
    "#def db_connection",
    "#  begin",
    '#    connection = PG.connect(dbname: "<database name>")',
    "#    yield(connection)",
    "#  ensure",
    "#    connection.close",
    "#  end",
    "#end\n\n",
    "#request the data from your table",
    "#def get_data",
    "#  <your variable> = db_connection do |conn|",
    '#    conn.exec("SELECT <rows names> FROM <table name>")',
    "#  end",
    "#end\n\n",
    "###############",
    "# CONTROLLERS #",
    "###############\n\n",
    "get '/' do",
    "  redirect '/home'",
    "end\n\n",
    "get '/home' do",
    "  erb :home",
    "end"
    ],
 # Your own JavaScript file
  "#{path}/public/js/#{project_name}.js" => [
    "// The canvas for your awesome JS code"
    ],
 # Your own CSS file
  "#{path}/public/css/#{project_name}.css" =>[
    "/* Let's put some makeup! */"
    ],
 # The layout file already linked to the CSS files and JS
  "#{path}/views/layout.erb" => [
    "<!DOCTYPE html>",
    "<html lang='en'>",
    "<head>",
    "  <meta charset='UTF-8'>",
    "  <title>My New Awesome Application</title>",
    "  <link rel='stylesheet' href='/css/vendor/foundation.min.css'>",
    "  <link rel='stylesheet' href='/css/vendor/normalize.css'>",
    "  <link rel='stylesheet' href='/css/#{project_name}.css'>",
    "</head>",
    "<body>",
    "  <div class='row'>\n\n",
    "    <%= yield %>\n\n",
    "  </div>",
    "  <script src='/js/vendor/jquery-2.1.3.min.js'></script>",
    "  <script src='/js/#{project_name}.js'></script>",
    "</body>",
    "</html>"
    ],
  "#{path}/views/home.erb" => [
    "<h1>My New Awesome Application</h1>\n\n",
  ]
}

vendor_files = [
  "foundation.min.css",
  "normalize.css",
  "jquery-2.1.3.min.js"
  ]

directories.each { |path_dir| system 'mkdir', '-p', path_dir }

files.keys.each { |path_file| system 'touch', path_file }

files.each do |file_path, info|
  File.open(file_path, 'w') do |file|
    info.each { |line| file.puts(line) }
  end
end

vendor_files.each do |vfile_name|
  extension = vfile_name.scan(/\.(\w{2,3})\z/i).join
  system 'cp', "./public/#{vfile_name}", "#{path}/public/#{extension}/vendor/"
end

success = "| Your #{project_name} project was successfully generated! |"

if File.directory?(path)
  puts "#{'-'*success.size}\n#{success}\n#{'-'*success.size}"
else
  puts "#{'-'*30}\n| Something went wrong, ups! |\n#{'-'*30}"
end
