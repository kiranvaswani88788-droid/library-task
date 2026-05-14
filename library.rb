require_relative "custom_exception"
require_relative "book"
require_relative "validation"
require_relative "storage"
require_relative "member"
class Library
	include Validation
	include Storage
  attr_accessor :books
  def initialize
    @books=[]
  end
  


 def create_book 
    puts "enter author name"
    @author_name=gets.chomp

    puts "enter book details"
    @book_details=gets.chomp

    @id=generate_id
      
    begin

    	validate_book_details(@author_name,@book_details)
      @availability=true
    	book=Book.new(@author_name,@book_details,@id,@availability)
      save_book(@author_name,@book_details,@id,@availability)
      show_confirmation
    rescue Custom_Exception => e
    	puts e.message
    end

  end


 def list_book
   list_book
 end


 def generate_id
   Random.rand(1..999)  
 end
    
 def show_confirmation
  puts "here is the confirmation"
  puts "author_name : #{@author_name}"
  puts "book_details : #{@book_details}"
  puts "id : #{@id}"
  puts "availability : #{@availability}"
 end

 def add_member
    puts "Enter your name"
    name=gets.chomp
   @id=generate_id

  begin
    validate_member_name(name)
    save_member(name,@books,@id)
    member=Member.new(name,@books,@id)
   rescue Custom_Exception => e
    puts e.message
  end 
    Storage.member_list
 end

 def borrow_book
  puts "enter member id"
  input_member_id=gets.chomp
  puts "enter book id"
  book_id=gets.chomp
  
   
   validate_member_id(input_member_id)
  rescue Custom_Exception=> e
   puts e.message
  
   search_book(book_id)

   is_available=check_availability
    if(is_available)
      puts "true"
    end
    
  end





end
 obj=Library.new
 puts obj.books
