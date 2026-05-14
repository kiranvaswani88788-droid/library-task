require "json"
module Storage
	def save_book(author_name,book_details,id,availability)
    	hash={
    		author_name: author_name, 
    		book_details: book_details, 
    		id: id,
    		availability: availability
    		}
    	File.open("book_store.txt","a") do |file|
      		file.puts(JSON.pretty_generate(hash))
      	puts "data save successfuly"
    	end
 	end

 	def list_book
 		puts "list of books"
 		File.open("book_store.txt","r") do |file|
 			puts file.read
 		end
 	end

    def save_member(name,books,id)
    	hash={
    		name: name, 
    		books: books,
    		id: id
    		}

      	File.open("member_data.txt","a") do |file|
      		file.puts(JSON.pretty_generate(hash))
      	puts "member save successfuly"
    	end
    end

    def member_list
 		File.open("member_data.txt","r") do |file|
 			puts file.read
 		end
 	end

 	def search_member(input_member_id)
        
 		File.foreach("member_data.txt","r") do |file|
 			if file.include?(input_member_id)
 				retru true
 			end
          
		end
 	end

 	def search_book(book_id)

 		File.foreach("book_store.txt","r") do |file|
 			if file.include?(book_id)
 			return true
 			end
		end
 		puts "book not found"
 	end
    
    def check_availability
    	member_availability=search_member
        book_availability=search_book
      return member_availability && book_availability
    end

end