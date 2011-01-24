class Organization < ActiveRecord::Base
    has_and_belongs_to_many :publications
    
    def to_s
        return name        
    end
    
    def find_by_name(name)
        if (Organization.exists?(:conditions => ["tolower(name) like ?", name.downcase))
            return Organization.find(:first, :conditions => ["tolower(name) like ?", name.downcase])
        end
        return nil
    end
    
end
