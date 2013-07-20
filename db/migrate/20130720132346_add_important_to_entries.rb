class AddImportantToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :important, :boolean
  end
end
