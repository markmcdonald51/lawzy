class AddCountOfTermsSearchesToTerms < ActiveRecord::Migration[5.0]
  def change
    add_column :terms, :count_of_searches, :integer, default: 0
  end
end
