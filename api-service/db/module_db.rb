require 'sqlite3'

# модуль для работы с базой
module DBApp
  class << self
    attr_accessor(
      :path_db,
      :adapter
      )

    def config
      yield(self)
    end

    def create_version_table     
      db = SQLite3::Database.new(DBApp.path_db)
      db.execute("create table if not exists
        VersionUpdate
        (
        name_bank text primary key,        
        last_v INTEGER DEFAULT (unixepoch())
        )
        ;")
    end 
  end
end
