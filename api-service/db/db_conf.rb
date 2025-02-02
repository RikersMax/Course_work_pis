require_relative 'module_db.rb'


path = Dir.pwd.gsub(%r{/api-service$}, '/api-service/storage/db.sqlite3')

puts path

DBApp.config do |conf| 
  conf.adapter = 'sqlite3'
  conf.path_db = path
  conf.create_version_table
end
