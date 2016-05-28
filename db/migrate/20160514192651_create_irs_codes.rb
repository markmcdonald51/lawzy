class CreateIrsCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :irs_codes do |t|
      t.string :trans_code
      t.string :dr_cr_file
      t.string :title
      t.string :valid_doc_code
      t.text :remarks

      t.timestamps
    end
  end
end
