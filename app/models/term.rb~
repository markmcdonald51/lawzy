class Term < ApplicationRecord
  acts_as_tree
  belongs_to :dictionary
  #validates_uniqueness_of :name, scope: :dictionary, allow: nil
  belongs_to :parts_of_speech
  
  has_many :term_search_logs  # 
  has_many :users, through: :term_search_logs

#=begin 
  searchable do
    text :name
    text :definition
    integer :parent_id
    integer :dictionary_id
  end  
#=end
  
end
