require 'sqlite3'
require 'yaml'

#db = SQLite3::Database.new('path')

file = YAML.load_file('seeds.yaml')


def create_table(connect, name_table)
    connect.execute("create table if not exists 
      #{name_table} 
      (id integer primary key,
      name text,
      title_vklad text,
      rate real,
      minimum_currency integer,      
      month integer,
      deposit text ,
      withdrawal text
      check(deposit in('true', 'false'))
      check(withdrawal in('true', 'false'))
      );")
  
end

def insert_into(connect, name_table, values)
  connect.execute("insert into #{name_table} 
      (name, title_vklad, rate, minimum_currency, month, deposit, withdrawal)
      values
      (?, ?, ?, ?, ?, ?, ?);",
      values)
  
end

file.each do |k, v| 
  v.map do |item|
    item['deposit'] = item.delete('deposit').to_s
    item['withdrawal'] = item.delete('withdrawal').to_s 
  end
  
  v.each do |item|
    i = item.values

    insert_into(db, k, i)
    puts i.inspect
    puts ('======================')
  end
end