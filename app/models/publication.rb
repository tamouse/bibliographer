class Publication < ActiveRecord::Base
    has_and_belongs_to_many :organizations
    has_many :roles, :conditions => {:roletype => 0}
    has_many :authors, :class_name => "Person", :through => :roles, :conditions => {:roletype => 0}
    has_many :editors, :class_name => "Person", :through => :roles, :conditions => {:roletype => 1}
    has_and_belongs_to_many :tags
    

    def add_authors(authorString)
        @theseauthors = Person.string_to_people(authorString)
        return true unless @theseauthors
        @theseauthors.each do |thisauthor|
            role = Role.new(:publication_id => id, :person_id => thisauthor.id, :roletype => 0)
            if (!role.save)
                raise "Failed to save role in add_authors"
                return false
            end
        end
        return true
    end
    
    def add_editors(editorString)
        @theseeditors = Person.string_to_people(editorString)
        return true unless @theseeditors
        @theseeditors.each do |thiseditor|
            role = Role.new(:publication_id => id, :person_id => thiseditor.id, :roletype => 0)
            if (!role.save)
                raise "Failed to save role in add_editors"
                return false
            end
        end
        return true
    end

    def add_tags(tagString)
        tags = Tag.string_to_tags(tagString)
        return true
    end
    
    def update_authors(authorString)
        @theseauthors = Person.string_to_people(authorString)
        @thispubsauthors = this.authors
        # See if there are any new authors
        @theseauthors.each do |thisauthor|
            if (!@thispubsauthors.includes?(thisauthor))
                role = Role.new(:publication_id => id, :person_id => thiseditor.id, :roletype => 0)
                if (!role.save)
                    raise "Failed to save role in update_authors"
                    return false
                end
            end
        end
        # See if there are any authors to delete
        @thispubsauthors.each do |thisauthor|
            if (!@theseauthors.includes?(thisauthor))
                role = Role.find(:publication_id => id, :person_id => thiseditor.id)
                role.destroy
            end
        end
        return true
    end
    
    def update_editors(editorString)
        @theseeditors = Person.string_to_people(editorString)
        @thispubseditors = editors
        # See if there are any new editors
        @theseeditors.each do |thiseditor|
            if (!@thispubseditors.includes?(thiseditor))
                role = Role.new(:publication_id => id, :person_id => thiseditor.id, :roletype => 1)
                if (!role.save)
                    raise "Failed to save role in update_editors"
                    return false
                end
            end
        end
        # See if there are any editors to delete
        @thispubseditors.each do |thiseditor|
            if (!@theseeditors.includes?(thiseditor))
                role = Role.find(:publication_id => id, :person_id => thiseditor.id)
                role.destroy
            end
        end
        return true
    end
    
    def update_tags(tagString)
        @thesetags = Tag.string_to_tags(editorString)
        @thispubstags = tags
        # See if there are any new tags
        @thesetags.each do |thistag|
            if (!@thispubstags.includes?(thistag))
                this.tags<<thistag
            end
        end
        # See if there are any tags to delete
        @thispubstags.each do |thistag|
            if (!@thesetags.includes?(thistag))
                this.tags.delete(thistag)
            end
        end
        return true
    end
end
