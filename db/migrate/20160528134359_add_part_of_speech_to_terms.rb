class AddPartOfSpeechToTerms < ActiveRecord::Migration[5.0]
  def change
    add_column :terms, :part_of_speech, :string
    add_index(:terms, :name)
  end
end
