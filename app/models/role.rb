class Role < ActiveRecord::Base
    belongs_to :people
    belongs_to :publications
end
