#require_relative 'modules/base_module.rb'
#require_relative 'modules/alfa_api.rb'


#alfa = AlfaBank.new
#print alfa.init_version_table.inspect
#puts alfa.name_table.inspect

#db = SQLite3::Database.new(DBApp.path_db)


#print db.execute("select * from AlfaBank ")

#db.create_function("my_custom_func", table) do |func|
#  func.result = 'select * from VersionUpdate'
#end













=begin

x = BaseModule.new

#x.connect.execute("update TBank set updated_at = #{Time.now.to_i} where id = 1 ")

arr = []
bank = x.connect.execute("select * from TBank")
arr << bank
bank = x.connect.execute("select * from SberBank")
arr << bank
bank = x.connect.execute("select * from AlfaBank")
arr << bank



arr.each do |item|
  item.each do |row|
    #puts time
    x.connect.execute("update AlfaBank set updated_at = #{Time.now.to_i} where id = #{row['id']} ")
    #puts item
  end
end
#x.connect.execute("delete from TBank where id = 6")

=end



# db = SQLite3::Database.open('')