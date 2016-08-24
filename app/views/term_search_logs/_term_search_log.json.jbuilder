json.extract! term_search_log, :id, :term_id, :user_id, :created_at, :updated_at
json.url term_search_log_url(term_search_log, format: :json)