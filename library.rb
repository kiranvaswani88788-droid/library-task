require "date"
require "json" 
require_relative "custom_exception"
require_relative "book"
require_relative "validation"
require_relative "storage"
require_relative "member"

class Library
	include Validation
	include Storage
  attr_accessor :books, :members, :unique_id

  def initialize
    @books= File.exist?("book_store.txt") ? JSON.parse(File.read("book_store.txt")).map { |b| Book.new(b["author_name"], b["book_details"], b["id"], b["availability"]) } : []
    @members=File.exist?("member_data.txt") ? JSON.parse(File.read("member_data.txt")).map { |m| Member.new(m["name"], m["borrow_details"], m["id"]) } : []
    @book_id= File.exist?("book_store.txt") ? JSON.parse(File.read("book_store.txt")).last['id'] : 0
    @member_id= File.exist?("member_data.txt") ? JSON.parse(File.read("member_data.txt")).last['id'] : 0
  end


  def create_book 
      puts "enter author name"
      @author_name=gets.chomp

      puts "enter book details"
      @book_details=gets.chomp

      
    begin
    	validate_book_details(@author_name,@book_details)
      @id=generate_id
    	book=Book.new(@author_name,@book_details,@id,true)
      @books << book
      save_book(@author_name,@book_details,@id,true)
      show_confirmation
    rescue Custom_Exception => e
    	puts e.message
      create_book
    end
  end


 def list_book_details
    if File.exist?("book_store.txt")
      list_book
    else
      puts "book not found"
    end
 end



 def generate_id
    return @book_id += 1
 end


 def generate_member_id
    return @member_id += 1
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
    @name=gets.chomp
    borrow_details=[]
  begin
    validate_member_name(@name)
    @id=generate_member_id
    member=Member.new(@name, borrow_details, @id)
    members << member
    save_member(@name, borrow_details, @id)
  rescue Custom_Exception => e
    puts e.message
    add_member
  end 
 end



 def show_members_list
    if File.exist?("member_data.txt")
      member_list
    else
      puts "book not found"
    end  
 end





def borrow_book
    if File.exist?("book_store.txt")
      list_book
    end

    if File.exist?("member_data.txt")
      member_list
      puts "enter member id"
      input_member_id=gets.chomp
      puts "enter book id"
      book_id=gets.chomp
  
      begin
        validate_id(input_member_id,book_id)
        is_exists = verify_member_and_book(input_member_id, book_id)
  
        if is_exists
          book = @books.find { |b| b.id == book_id.to_i }
          if book.availability == false
            puts "book is already borrowed"
          else
            update_book_availability(book_id)
            update_member_books(input_member_id, book_id)
          end
        else
            puts "member or book not found"
        end
      rescue Custom_Exception => e
          puts e.message
          borrow_book
      end 
    end
 end



  def update_book_availability(book_id)

      book = books.find { |b| b.id == book_id.to_i }

      if book.nil?
        puts "Book not found"
      return
      end

      book.availability = false

      update_book_in_file

      puts "Book availability updated successfully"

  end



  def update_member_books(input_member_id, book_id)

      member = members.find { |m| m.id == input_member_id.to_i}

      if member.nil?
        puts "Member not found"
      return
      end

      book = books.find { |b| b.id == book_id.to_i }

      if book.nil?
        puts "Book not found"
      return
      end

      borrow_book = {
        book_id: book.id,
        borrow_date: Date.today,
        due_date: Date.today + 14
      }

      member.borrow_details << borrow_book

      update_member_file

      puts "Book borrowed successfully"
      puts "Due date is #{Date.today + 14}"

  end


  def return_book
    puts "enter member id"
    input_member_id = gets.chomp
    puts "enter book id"
    book_id = gets.chomp

    begin
      validate  _id(input_member_id,book_id)
      member = @members.find { |m| m.id == input_member_id.to_i }

      if member.nil?
      puts "member not found"
      return
      end

      borrow = member.borrow_details.find { |b| (b[:book_id] || b["book_id"]) == book_id.to_i }
    
      if borrow.nil?
        puts "member has not borrowed this book"
      return
      end

      book = @books.find { |b| b.id == book_id.to_i }
      book.availability = true
      due_date = Date.parse((borrow[:due_date] || borrow["due_date"]).to_s)
      
      if Date.today > due_date
        puts "book returned late! overdue by #{(Date.today - due_date).to_i} days"
      else
        puts "book returned successfully"
      end

      member.borrow_details.delete(borrow)
      update_book_in_file
      update_member_file

    rescue Custom_Exception => e
      puts e.message
      return_book
    end
  end



def list_borrowed_books
      puts "enter member id"
      input_member_id = gets.chomp

  begin
      validate_member_id(input_member_id)
      member = @members.find { |m| m.id == input_member_id.to_i }
    
      if member.nil?
        puts "member not found"
      return
      end

      if member.borrow_details.nil? || member.borrow_details.empty?
        puts "no borrowed books"
      return
      end

      puts "borrowed books for #{member.name}:"

          member.borrow_details.each do |b|
              book = @books.find { |bk| bk.id == (b[:book_id] || b["book_id"]) }
              due_date = Date.parse((b[:due_date] || b["due_date"]).to_s)
              overdue = Date.today > due_date ? "overdue by #{(Date.today - due_date).to_i} days ": "on time"
              puts "book id: #{b[:book_id] || b["book_id"]} title: #{book&.book_details} borrow date: #{b[:borrow_date] || b["borrow_date"]} due date: #{b[:due_date] || b["due_date"]} status: #{overdue}"
          end

    rescue Custom_Exception => e
        puts e.message
        list_borrowed_books
    end
 end


def search_books
    puts "enter search keyword"
    keyword = gets.chomp

    results = @books.select do |b|
      b.author_name.include?(keyword) ||
      b.book_details.include?(keyword)
    end

    if results.empty?
      puts "no matches found"
    else
      puts "search results:"
    
      results.each do |b|
        status = b.availability ? "available" : "borrowed"
        puts "id: #{b.id} title: #{b.book_details} author: #{b.author_name} status: #{status}"
      end
    end
  end


end
