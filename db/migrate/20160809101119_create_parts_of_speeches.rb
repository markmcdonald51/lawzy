class CreatePartsOfSpeeches < ActiveRecord::Migration[5.0]
  def change
    create_table :parts_of_speeches do |t|
      t.string :name
      t.string :abbreviation
      t.text :description

      t.timestamps
    end
  end
end
