class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   "provider"
      t.string   "email"
      t.string   "name"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "gender"
      t.string   "image_url"
      t.string   "oauth_token"
      t.string   "aasm_state"
      t.string   "country_code"
      t.string   "postal_code"
      t.decimal  "lat",                          precision: 15, scale: 10
      t.decimal  "lng",                          precision: 15, scale: 10
      t.boolean  "is_application_administrator",                           default: false
      t.integer  "login_count",                                            default: 0
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
