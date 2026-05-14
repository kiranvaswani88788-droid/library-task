
class Book
  attr_accessor  :author_name ,:book_details, :id , :availability

  def initialize(author_name,book_details,id, availability)
    @author_name=author_name
    @book_details=book_details
    @id=id
    @availability=availability
  end
  
end
