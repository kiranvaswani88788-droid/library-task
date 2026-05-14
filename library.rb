require_relative "Custom_Exception"
require_relative "book"
require_relative "validation"
require_relative "storage"
class Library
	include Validation
	include Storage

 def self.create_book 
    puts "enter author name"
    author_name=gets.chomp

    puts "enter book details"
    book_details=gets.chomp
      
    begin
    	Validation.validate_book_details(author_name,book_details)
        Storage.save_book(author_name,book_details)
    	book=Book.new(author_name,book_details)
    rescue Custom_Exception => e
    	puts e.message
    end
  end
end