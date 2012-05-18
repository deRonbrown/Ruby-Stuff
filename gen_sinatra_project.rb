app_name = ARGV[0]
if app_name.nil?
  puts "An app name must be specified."
  exit
end

# Create folders
folders = [app_name, "#{app_name}/public", "#{app_name}/public/javascript", "#{app_name}/public/css", "#{app_name}/views", "#{app_name}/config", "#{app_name}/db", "#{app_name}/helpers", "#{app_name}/models", "#{app_name}/routes"]
folders.each do |f|
  if not FileTest::directory?(f)
    Dir::mkdir(f)
  else
    puts "Folder '#{f}' already exists"
    exit
  end
end

# app.rb
open("#{app_name}/app.rb", 'a') { |f|
  f << "require 'sinatra'\n"
  f << "require 'json'\n\n"
  f << "class #{app_name} < Sinatra::Application\n\n"
  f << "\t# Set defaults\n"
  f << "\tconfigure do\n\n"
  f << "\tend\n\n"
  f << "end\n\n"
  f << "require_relative 'routes/init'\n"
  f << "require_relative 'models/init'\n"
  f << "require_relative 'helpers/init'\n"
}

# Gemfile
open("#{app_name}/Gemfile", 'a') { |f|
  f << "source :rubygems\n\n"
  f << "# Web container\n"
  f << "gem 'rack'\n\n"
  f << "# Web Framework\n"
  f << "gem 'sinatra'\n"
  f << "gem 'sinatra-respond_to'\n\n"
  f << "# Parsing/Content-types\n"
  f << "gem 'json'"
}

# config.ru
open("#{app_name}/config.ru", 'a') { |f|
  f << "root = ::File.dirname(__FILE__)\n"
  f << "require ::File.join(root, 'app')\n\n"
  f << "run #{app_name}.new"
}

# database.yml
open("#{app_name}/db/database.yml", 'a')

# helpers/init.rb
open("#{app_name}/helpers/init.rb", 'a') { |f|
  f << "# Helper relatives\n"
  f << "#require_relative 'helper_one'"
}

# models/init.rb
open("#{app_name}/models/init.rb", 'a') { |f|
  f << "# Model relatives\n"
  f << "#require_relative 'model_one'"
}

# routes/init.rb
open("#{app_name}/routes/init.rb", 'a') { |f|
  f << "class #{app_name} < Sinatra::Application\n\n"
  f << "\tbefore do\n\n"
  f << "\tend\n\n"
  f << "end\n\n"
  f << "require_relative 'main'" 
}

# routes/main.rb
open("#{app_name}/routes/main.rb", 'a') { |f|
  f << "class #{app_name} < Sinatra::Application\n\n"
  f << "\tget '/' do\n"
  f << "\t\t'Hello, World'\n"
  f << "\tend\n\n"
  f << "end" 
}