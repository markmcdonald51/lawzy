class AddSearchCountToTermSearchLog < ActiveRecord::Migration[5.0]
  def change
    add_column :term_search_logs, :search_count, :integer, default: 1
  end
end
