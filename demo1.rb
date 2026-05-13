require "json"
require_relative "module.rb"

class Main < StandardError
	extend Book
	def self.show
		 puts "Welcome to Library catalog"
	   puts "1. Add Book \n2. List Books \n3. Add Member \n4. Borrow Book \n5. Return Book \n6. List Borrowed Books (by member) \n7. Search Books \n8. Exit"
	   Main.show2
	end
	 
	def self.show4
		if($autor_name.match?(/\d+/))
		
			begin
			raise ArgumentError, "invalid string" 
  		rescue ArgumentError => e 
  			puts e.message
  		end
    else
    	show3
    end
  end

	def self.show2
	
  	input=gets
 		case input.to_i
		when 1
			show3
			return
		end
	end



end
	Main.show
	
