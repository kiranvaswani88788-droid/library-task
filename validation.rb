module Validation
 	def validate_book_details(author_name,book_details)

   		if(author_name.strip.empty? || book_details.strip.empty?)
            raise Custom_Exception.new("Enter valid string")
    	end


        
   		if(author_name.length<=2 || book_details.length<=2)
            raise Custom_Exception.new("Enter valid details")
    	end

         
        if(book_details.match?(/[^a-zA-Z0-9\s]/))
             raise Custom_Exception.new("invalid string")
        end

        if(book_details.match?(/\A\d+\z/))
             raise Custom_Exception.new("invalid string")
        end

    	if(author_name.match?(/[^a-zA-Z0-9\s]/))
             raise Custom_Exception.new("invalid string")
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

    def validate_id(input_member_id,book_id)
        if !input_member_id.match?(/\A\d+\z/)
            raise Custom_Exception.new("enter only number")
        end

        if !book_id.match?(/\A\d+\z/)
            raise Custom_Exception.new("enter only number")
        end

        if(input_member_id.match?(/[^a-zA-Z0-9\s]/))
            raise Custom_Exception.new("invalid string")
        end


        if(book_id.match?(/[^a-zA-Z0-9\s]/))
            raise Custom_Exception.new("invalid string")
        end
    end


end