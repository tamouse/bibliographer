class Person < ActiveRecord::Base
    has_many :roles
    has_many :publications, :through => :roles
    
    def Person.string_to_people(s)
        if (! s) or (s === "")
            return nil
        end
        names = s.split(", ")

        thesenames = Array.new
        
        names.each do |name|
            aName = PeopleHelper.splitName(name)
            foundName = Person.find(:first, :conditions => {:firstname => aName[0], :lastname => aName[1]})
            if (!foundName)
                foundName = Person.new(:firstname => aName[0], :lastname => aName[1])
                foundName.save
            end
            thesenames<<foundName
        end
        return thesenames
    end
end
