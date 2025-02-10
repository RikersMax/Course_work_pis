require_relative 'base_module.rb'

class AlfaBank < BaseModule 

  attr_reader :name_table

  def initialize
    connect
    @name_table = 'Alfa_bank'
    create_table()
    init_version_table()
  end
end
