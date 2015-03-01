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

files = {
  "#{path}/.gitignore" => [
    ".env"
    ],
  "#{path}/Gemfile" => [
    "#share all the gems that your awesome app needs",
    "source 'https://rubygems.org/'\n\n",
    "gem 'sinatra'"],
  "#{path}/server.rb" => [
    "require 'sinatra'",
    "require 'erb'",
    "#this is dedicated to Spencer, great EE who show us the power of pry!",
    "require 'pry'\n\n",
    "get '/' do",
    "  redirect '/home'",
    "end\n\n",
    "get '/home' do",
    "  erb :home",
    "end"],
  "#{path}/public/js/#{project_name}.js" => [
    "// The canvas for your awesome JS code"
    ],
  "#{path}/public/css/#{project_name}.css" =>[
    "/* Let's put some makeup! */"
    ],
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
    "  <script src='/#{project_name}.js'></script>",
    "</body>",
    "</html>"],
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
