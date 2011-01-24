class Tag < ActiveRecord::Base
    has_and_belongs_to_many :publications
    
    def Tag.string_to_tags(s)
        if (! s) or (s === "")
            return nil
        end
        
        tags = Array.new
        
        tokens = s.split(", ")
        tokens.collect! {|t| t.strip.sub(/[[:punct:]]/,"").downcase}
        tokens.each do |t|
            tag = Tag.find(:first, :conditions => {:name => t})
            if (! tag)
                tag = Tag.new(:name => t)
                tag.save
            end
            tags << tag
            
        end
        return tags
    end
end
