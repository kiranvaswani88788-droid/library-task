class Book
  attr_accessor  :author_name ,:book_details
  
  def initialize(author_name,book_details)
    @author_name=author_name
    @book_details=book_details
  end

  def validate_book_details
    if((author_name != "" && book_details != "") && (author_name.length>=2 && book_details.length>=2))
       puts "if successfully"
    else
      puts "hello else"
    end 
  end
end
