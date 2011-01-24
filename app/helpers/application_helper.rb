# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    
    # Define some associations for human-readable versions of items in the publications table
    @@priorities = ["0 (read)", "1 (will not read)", "2 (maybe read)", "3 (will read)", "4 (must read)"]

    @@months = ["", "January", "February", "March", "April", "May", "June", "July", "August", 
                "September", "October", "November", "December"]

    @@types = ["Misc", "Book", "InBook", "Article", "Manual","MastersThesis", "PhDThesis", "Proceedings" , "InProceedings", "TechReport"]
    
    def ApplicationHelper.priorities
        return @@priorities        
    end
    
    def ApplicationHelper.months
        return @@months
    end
    
    def ApplicationHelper.types
        return @@types
    end
    
end
