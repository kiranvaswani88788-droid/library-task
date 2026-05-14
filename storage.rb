require "Json"
module Storage
	def self.save_book(author_name,book_details)
    	hash={author_name: author_name, book_details: book_details}
    	File.open("book_store.txt","a") do |file|
      		file.puts(JSON.pretty_generate(hash))
      	puts "data save successfuly"
    	end
 	end
end