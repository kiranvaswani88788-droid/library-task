require_relative "library"
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
        Library.create_book 
    end
  end

  
end

obj=Main.new
obj.panel