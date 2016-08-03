class Dictionary < ApplicationRecord
  has_many :terms
  validates_uniqueness_of :name
  
  has_one :logo, as: :attachable, class_name: 'Attachment'
  accepts_nested_attributes_for :logo
end
