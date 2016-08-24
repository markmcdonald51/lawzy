class PartOfSpeechChangeColumnType < ActiveRecord::Migration[5.0]
  def change
    remove_column(:terms, :part_of_speech, :string)
    remove_column(:terms, :parts_of_speech, :string)
    add_column(:terms, :parts_of_speech_id, :integer)
  end
end
