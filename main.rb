require_relative "book.rb"
require_relative "exception"
class Main
  def panel
    puts "Welcome to Library catalog"
    puts "1. Add Book \n2. List Books \n3. Add Member \n4. Borrow Book \n5. Return Book \n6. List Borrowed Books (by member) \n7. Search Books \n8. Exit"
    select_option
  end
    
  def select_option
    input=gets.chomp
    case input.to_i
    when 1
        create_book 
    end
  end

  def create_book 
    puts "enter author name"
    author_name=gets.chomp

    puts "enter book details"
    book_details=gets.chomp

    begin
      if(author_name.match?(/\d+/))
        raise CustomException.new("invalid string")
      end
    rescue CustomException => e
      puts e.message
    end 

    book=Book.new(author_name,book_details)
    book.validate_book_details
  end
end

obj=Main.new
obj.panel