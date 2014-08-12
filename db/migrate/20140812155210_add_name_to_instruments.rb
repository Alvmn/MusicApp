class AddNameToInstruments < ActiveRecord::Migration
  def change
  	add_column :instruments, :name, :string
  end
end
