class AddAbbreviationToDictionaries < ActiveRecord::Migration[5.0]
  def change
    add_column :dictionaries, :abbreviation, :string
  end
end
