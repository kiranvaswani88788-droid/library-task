require_relative "library"
class Main
  def initialize
    @obj=Library.new
  end

  def panel
    loop do
      puts "Welcome to Library catalog"
      puts "1. Add Book \n2. List Books \n3. Add Member \n4. List members \n5. Borrow Book \n6. Return Book \n7. List Borrowed Books (by member) \n8. Search Books \n9. Exit"
      select_option(@obj)
    end 
  end
    
  def select_option(obj)
    input=gets.chomp
    case input.to_i
    when 1
        @obj.create_book
    when 2
        @obj.list_book_details
    when 3
        @obj.add_member
    when 4
        obj.show_members_list
    when 5
        @obj.borrow_book
    when 6
        @obj.return_book
    when 7
        @obj.list_borrowed_books
    when 8
        @obj.search_books
    when 9
        puts "goodbye"
        exit
    end
 end
  
end

obj=Main.new
obj.panel

