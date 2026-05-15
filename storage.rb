require "json"
module Storage

 def save_book(author_name, book_details, id, availability)
    existing = File.exist?("book_store.txt") ? JSON.parse(File.read("book_store.txt")) : []
    existing << { author_name: author_name, book_details: book_details, id: id, availability: availability }
    File.open("book_store.txt", "w") { |f| f.write(JSON.pretty_generate(existing)) }
    puts "data saved successfully"
  
 end



 	def list_book
 		 puts "list of books"
 		 File.open("book_store.txt","r") do |file|
 		  puts file.read
 		 end
 	end

  def save_member(name, borrow_details, id)
    existing = File.exist?("member_data.txt") ? JSON.parse(File.read("member_data.txt")) : [] 

    existing << { name: name, borrow_details: borrow_details, id: id }
    File.open("member_data.txt", "w") { |f| f.write(JSON.pretty_generate(existing)) }
    puts "member saved successfully"
    
  end

  def member_list
    puts "here is member list"
 		File.open("member_data.txt","r") do |file|
 			puts file.read
 		end
 	end

 	def search_member(input_member_id)
        
 		File.foreach("member_data.txt","r") do |file|
 			if file.include?(input_member_id)
 				return true
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
    
  def verify_member_and_book(input_member_id,book_id)
    	member_exists=search_member(input_member_id)
      book_exists=search_book(book_id)
      return member_exists && book_exists
  end

  def update_book_in_file

    File.open("book_store.txt","w") do |file|
     file.write(JSON.pretty_generate(books.map { |b| 
       {
         author_name: b.author_name, 
         book_details: b.book_details, 
         id: b.id,
         availability: b.availability
       }
      }))
    end
  end

  def update_member_file
    File.open("member_data.txt","w") do |file|
      file.write(JSON.pretty_generate(members.map { |m| 
        {
          name: m.name, 
          borrow_details: m.borrow_details,
          id: m.id 
        }
       }))
    end
  end

end