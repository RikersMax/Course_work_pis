require_relative 'base_module.rb'

class SberBank < BaseModule
  include DBApp

  attr_reader :name_table

  def initialize
    connect
    @name_table = 'Sber_bank'  
    create_table
    init_version_table
  end
end
