class Member
	attr_accessor :name, :borrow_details, :id
	def initialize(name,borrow_details,id)
		@name=name
		@borrow_details=borrow_details
		@id=id
	end
end