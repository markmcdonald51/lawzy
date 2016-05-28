class Legal < ActiveRecord::Base
  acts_as_tree order: "title"
end
