require "json"
class Book
  attr_accessor  :author_name ,:book_details

  def initialize(author_name,book_details)
    @author_name=author_name
    @book_details=book_details
  end

  def validate_book_details
    if((author_name != "" && book_details != "") && (author_name.length>=2 && book_details.length>=2))
       save_book
    else
      puts "hello else"
    end 
  end

  def save_book
    hash={author_name: "#{author_name}", book_details: "#{book_details}"}
    File.open("book_store.txt","a") do |file|
      file.puts(JSON.pretty_generate(hash))
      puts "data save successfuly"
    end
  end

end
