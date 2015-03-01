# this is a simple routine to create the basic directories for a Sinatra
# application,
ARGV.empty? ? path = "./new-project" : path = ARGV.join

file_name = path.scan(/\.\/([\w\d_\-]+)\z/i).join

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
    "source 'https://rubygems.org/'",
    "",
    "gem 'sinatra'"],
  "#{path}/server.rb" => [
    "require 'sinatra'",
    "require 'erb'",
    "#this is dedicated to Spencer, great EE who show us the power of pry!",
    "require 'pry'\n\n",
    "get '/' do",
    "  redirect '/#here goes your name of choice'",
    "end"],
  "#{path}/public/js/#{file_name}.js" => [
    "// The canvas for your awesome JS code"
    ],
  "#{path}/public/css/#{file_name}.css" =>[
    "/* Let's put some makeup! */"
    ],
  "#{path}/views/layout.erb" => [
    "<!-- The foundations of your website serious stuff -->",
    "<!-- TIP: if you have the package Emmet installed puts a ! and then press tab -->"
  ]
}

directories.each { |path_dir| system 'mkdir', '-p', path_dir }

files.keys.each { |path_file| system 'touch', path_file }

files.each do |file_path, info|
  File.open(file_path, 'w') do |file|
    info.each { |line| file.puts(line) }
  end
end
