module PeopleHelper
    
    
    # Splits a name in a string into first and last names, somewhat intelligently.
    # Stolen from Citer, a GPL Rails project like this one to keep track of a bibliography
    def PeopleHelper.splitName(name)

      if name.index("{")
        hintedName = name[/^\{.*\}\s/]
        hintedSurname = name[/\s\{.*\}$/]
        if !hintedName
          hintedName = name[0,name.index("{")-1]
        elsif !hintedSurname
          hintedSurname = name[name.index("}")+2..-1]
        end
        return [hintedName.strip.delete("{}"), 
                hintedSurname.strip.delete("{}")]
      end

      parts = name.split("\s")

      if parts.length == 2 then return parts end

      name = String.new
      surname  = String.new

      lastpart = parts.pop

      insurname = false
      parts.each do |namepart|
        namepart.strip!
        insurname = true if namepart.match(/^[a-z]/)
        if insurname
          surname = surname + " " if !surname.empty?
          surname = surname + namepart
        else
          name = name + " " if !name.empty?
          name = name + namepart
        end
      end

      if !surname.empty? 
        surname = surname + " " +  lastpart
      else
        surname = lastpart
      end
      return [name, surname]
    end
    
    
end
