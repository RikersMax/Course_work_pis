require_relative 'base_module.rb'

class TBank < BaseModule
  include DBApp

  attr_reader :name_table

  def initialize
    connect
    @name_table = 'T_Bank'  
    create_table
    init_version_table
  end
end
