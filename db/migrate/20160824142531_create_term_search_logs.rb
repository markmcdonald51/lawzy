class CreateTermSearchLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :term_search_logs do |t|
      t.references :term, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
