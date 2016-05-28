class CreateTerms < ActiveRecord::Migration[5.0]
  def change
    create_table :terms do |t|
      t.string :name
      t.text :definition
      t.integer :parent_id
      t.references :dictionary, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
