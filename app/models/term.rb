class Term < ApplicationRecord
  acts_as_tree
  belongs_to :dictionary
  #validates_uniqueness_of :name, scope: :dictionary, allow: nil
  

 
  searchable do
    text :name
    text :definition
    integer :parent_id
    integer :dictionary_id
  end  

  
end
