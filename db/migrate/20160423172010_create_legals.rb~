class CreateLegals < ActiveRecord::Migration[5.0]
  def change
    create_table :legals do |t|
      t.string :title
      t.text :body
      t.integer :parent_id, index: true
      t.string :source

      t.timestamps
    end
  end
end
