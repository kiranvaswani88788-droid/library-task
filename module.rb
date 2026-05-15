module Book
	def show3
        id=Random.rand(1..100)
		puts "enter the author name"
		autor_name=gets.chomp

		puts "enter the book details"
		book_details=gets.chomp
        
       Main.show4
		availability = false 


		if((autor_name != "" && book_details != "") && (autor_name.length>=2 && book_details.length>=2))
	         
		  availability=true

		  hash={id:"#{id}",author_name:"#{autor_name}", book_details: "#{book_details}",availability: "#{availability}"}	
			
		  File.open("books.txt","a") do |file|
		  file.puts(JSON.pretty_generate(hash))
		  end
			
		  File.open("books.txt","r") do |file|
		  puts file.read
		  end
		
		else
		puts "Invalid Input Select Option Again"
		Main.show
		end
    end
end    
