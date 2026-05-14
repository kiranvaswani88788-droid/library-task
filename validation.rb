module Validation
 	def self.validate_book_details(author_name,book_details)
   		if((author_name != "" && book_details != "") && (author_name.length>=2 && book_details.length>=2))
       		return true
    	end
    	if(author_name.match?(/\A\d+\z/))
    		raise Custom_Exception.new("invalid string")
    	end
 	end 
end