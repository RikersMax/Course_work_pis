require_relative '../db/db_conf.rb'

class BaseModule
  include DBApp

  def connect
    db = SQLite3::Database.new(DBApp.path_db)    
    db.results_as_hash = true
    db     
  end

  def create_table
    connect.execute("create table if not exists 
      #{self.name_table} 
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

  def insert_into(hash)
    #создает массив из всех value хеша,
     
    arr_values = hash.inject([]) {|arr, (k, v)| arr << v}
    #arr_values << Time.now.to_i

    self.connect.execute("insert into #{self.name_table} 
      (name, title_vklad, rate, minimum_currency, month, deposit, withdrawal)
      values
      (?, ?, ?, ?, ?, ?, ?);",
      arr_values)
    
  end

  def select_data
    self.connect.execute("select * from #{self.name_table}")  
  end

  def init_version_table
    name_bank = self.connect.execute("select name_bank from VersionUpdate where name_bank = '#{self.name_table}'")[0]
    if name_bank.nil? then
      self.connect.execute("insert into VersionUpdate (name_bank) values (?)", [self.name_table])
    end 
  end

  def select_version
    result = self.connect.execute("select last_v from VersionUpdate where name_bank = '#{self.name_table}'")[0]
    {self.name_table => result['last_v']}
    #return result
  end

  #singleton methods

  def self.select_version_from_params(params_hash)
    arr = []
    params_hash.values.each do |v|
      result = SQLite3::Database.new(DBApp.path_db).execute("select * from VersionUpdate where name_bank = '#{v}'")[0]
      arr.push(v => result[1]) if !result.nil?   
    end

    if arr.empty?
      return({'error' => "bank not find #{params_hash.keys}"})
    else
      return(arr)
    end
  end

  def self.find_by_bank_and_id(name_bank, id_row)
    result_data = SQLite3::Database.new(DBApp.path_db).get_first_row("select * from #{name_bank} where id = #{id_row}")
    name_columns = SQLite3::Database.new(DBApp.path_db).table_info(name_bank).map {|col| col['name']}
    result = name_columns.each_with_index.inject(Hash.new) {|result, (value, index)| result[value] = result_data[index]; result }
    return result
  end

end
