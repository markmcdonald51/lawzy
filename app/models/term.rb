class Term < ApplicationRecord
  acts_as_tree
  belongs_to :dictionary
  #validates_uniqueness_of :name, scope: :dictionary, allow: nil
  
  
  searchable do
    text :name, :definition
    #text :dictionay do
    #  dict.map { |comment| comment.body }
    #end

    integer :parent_id
    integer :dictionary_id
    
    #string  :sort_title do
    #  title.downcase.gsub(/^(an?|the)/, '')
    #end
  end  
  
end
