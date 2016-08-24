class TermSearchLog < ApplicationRecord
  belongs_to :term
  belongs_to :user
end
