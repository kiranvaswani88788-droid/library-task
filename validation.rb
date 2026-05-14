module Validation
 	def validate_book_details(author_name,book_details)

   		if(author_name.strip.empty? && book_details.strip.empty?)
            raise Custom_Exception.new("Enter valid string")
    	end


        
   		if(author_name.length<=2 && book_details.length<=2)
            raise Custom_Exception.new("Enter valid details")
    	end


    	if(author_name.match?(/\A\d+\z/))
    	    raise Custom_Exception.new("invalid string")
    	end

 	end 


    def validate_member_name(name)
        if(name.strip.empty?)
            raise Custom_Exception.new("enter invlaid name")
        end

        if(name.length<=2)
            raise Custom_Exception.new("enter valid name")
        end

        if(name.match?(/\A\d+\z/))
            raise Custom_Exception.new("enter valid string")
        end
    end

    def validate_member_id(input_member_id)
        if input_member_id.is_a?(String)
            raise Custom_Exception.new("enter only string")
        end
    end


end