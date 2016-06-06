  class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :asset
      t.string :name
      t.text :summary
      t.references :attachable, polymorphic: true, index: true
      t.integer :position
      t.string :usage, index: true

      t.timestamps
    end
  end
end
