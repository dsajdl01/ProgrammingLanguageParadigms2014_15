require "singleton"

/
* Class Calender has instance variable date and has singleton costructor. 
* Calencer calss deal with day by using Time class
* 
* @author David Sajdl
* @username dsajdl01
* @version 10-01-2015
*
* /
class Calender

	# calender class include singleton for constructor and require time
	include Singleton
	require 'time'
	# setting instance vatiables
	attr_accessor :day
	/
	*constructor initialize instance variable day to zero/
	def initialize()
			@day = 0
	end

	/
	* get_date() method sets day value to current day
	* 
	* @return string current day in format day-month-year /
	def get_date()
		@day = Time.now
		return day.strftime("%d-%m-%Y")
	end
	/
	* get_today_date() method returns current day
	*
	* @return Time as a current day and time
	* @throws exception if day instance variable is null/
	def get_today_date()
		if(day == 0)
			raise "Time is not set as the libary is not open."
		end
		return day
	end
	/
	*advance() method returns day with seven days ahead from current day
	*
	* @return Time as seven days ahead from current day and time
	* @throws exception if day instance variable is null/
	def advance()
		if(day == 0)
			raise "Time is not set as the libary is not open."
		end
		return @day + (2*7*12*60*60) 
	end
	/
	* count_diff_between_today() methods count different between passing day 
	* in a parameter and current day
	*
	* @param date as Time 
	* @return integer that is the different between today and date from parameter
	* @throws exception if day instance variable is null /
	def count_diff_between_today(date)
		#require 'time'
		if(day == 0)
			raise "Time is not set as the libary is not open."
		end
		if(date.class != Time)
			date = Time.parse(date)
		end
		return (day.to_date - date.to_date).to_i
	end
end
/
* class Calencer below assign accessibility as a private for instanc variable called day
*/
class Calender
	private :day
end

/
* Class Book has instance variable id, title, author and due_date. 
* Each Book object represents a book in the library.
*
* @author David Sajdl
* @username dsajdl01
* @version 10-01-2015
* 
*/
class Book
	# setting instance vatiables
	attr_accessor :id, :title, :author,  :due_date 
	/
	* constructor with 3 arguments book's id, book,s title and book's author/
	def initialize(id, title, author)
		@id = id
		@title = title
		@author = author
		@due_date = nil
	end
	/
	*get_id() method returns book's id
	*
	* @return string book's id /
	def get_id()
		return @id
	end
	/
	* get_title() method returns book's title
	*
	* @return string boob's title/
	def get_title()
		return @title
	end
	/
	* get_author() method returns book's author
	*
	* @return string book's author/
	def get_author()
		return @author
	end
	/
	*get_due_date() method returns book's due day
	*
	*@return string book's due date /
	def get_due_date()
		return due_date
	end
	/
	* check_out() method sets due date of the book to the date by passing through the methods parameter
	*
	* @param date that set book's due date /
	def check_out(due_date)
		@due_date = due_date
	end
	/
	* get_check_in() method sets book's due date to null /
	def get_check_in()
		@due_date = nil
	end
	/
	*to_s() method returns book's id, title and author
	*
	* @return string with book's id, book's title and book's author /
	def to_s()
		return "Id: " + get_id + " Title: " + get_title + " by author: " + get_author
	end
end
/
* class Book below assign accessibility as a private for 
* instanc variable called id, title, author and due_date
*/
class Book
	private :id
	private :title 
	private :author  
	private :due_date
end

/
* Class Member had 3 instance variables member's name , member's id 
* and library as array that contain books that member borrow or null
* Member class represents members of the library and books that member borrows  
*
* @author David Sajdl
* @username dsajdl01
* @version 10-01-2015
*
*/
class Member
	#initialize instance variables
	attr_accessor :name, :library, :ids
	/
	*constructor with two parameters members name ans library (books that member borrows) 
	*/
	def initialize(name, library)
		@library = []
		@library[0] = library
		@library[1] = library
		@library[2] = library
		@name = name
		@ids = get_members_id()
	end
	/
	*get_name() method returns member's name
	*
	* @return string member's name /
	def get_name()
		return @name
	end
	/
	*get_membersId() method returns member's id
	*
	* @return string member's id /
	def get_memberId()
		return ids
	end
	/ 
	* check_out() method sets books to the member. If member has already 3 books 
	* and want to borrowed onother one it throws exception member has already borrowed 3 books!
	*
	* @param Book object as book that member wish to borrow 
	* @throws exception if the member try to borrow fourth book. /
	def check_out(book)
		i = 0
		found = true
		while (i < library.size())
			if(library[i] == nil)
				library[i] = book
				found = false
				i = 3
			end
			i = i + 1
		end
		
		if(found)
			raise name + " has already borrowed 3 books!"
		end
						
	end
	/
	* give_back() method returns or give back the books that member borrowed 
	* Method also sends message to delete the book from the .txt file.
	*
	*@param book object that is return book /
	def give_back(book)
		i = 0
		while(i < library.size())
			if(library[i].eql?(book))
				library[i] = nil
				delete_books_from_file(book.get_id())
				book.get_check_in()
				i = 3
			end
			i = i + 1
		end
	end
	/
	* delete_books_from_file() method opens lending.txt file and delete record of the returning book
	*
	* #param string book's id that is id of the book that member returning /
	def delete_books_from_file(id)
		f = File.open("ruby/lending.txt", 'r')
		id = id.to_s
		messabe_to_add = ""
		while line = f.gets
			ln = line.split(',')
			bookib = ln[1].strip
			if(bookib != id.delete(' '))
				messabe_to_add = messabe_to_add + line
			end
		end
		f = File.open("ruby/lending.txt", 'w') 
		f << messabe_to_add
		f.close
	end
	/
	* get_books returns list 'array' of the books that member borrowed
	*
	* @return array list of the books that member borrows. If the member does not borrow any books list contain null value /
	def get_books()
			return library
	end
	/
	* send_over_notice() method checks which books are overdue and send list 
	* with overdue book's id and book's title with notice and member's name. 
	* If none of the books is overdue returns No books are overdue
	*
	* @param string notice that would display in the list if the member overdue book
	* @return either array of the list with overdue book's id and title,  member's name and notice or
	* if there are not overdue books it returns string "No books are overdue"
	*/
	def send_over_notice(notice)
		message = []
		c = Calender.instance
		i = 0
		mesg_i = 0
		while (i < library.size())
			if(library[i] != nil)
					str_due_date = library[i].get_due_date().to_s
					date = Time.parse(str_due_date)
					if(c.count_diff_between_today(date) > 0)
							message[mesg_i] = name + " "+ notice + " " + library[i].get_id + " " + library[i].get_title
							mesg_i = mesg_i + 1
					end				
			end
		i = i +	1	
		end
		if(message.length == 0)
			return name + " NO books are overdue."
		end
		return message
	end
	/ 
	* get_memberId() private method open members.txt file and search for member's id by compering member's name.
	* 
	*
	* @return string as member's get_id
	* @throws No such file or directory if txt file is not found
	* @throws "The member's name does not match with our system!" however its unlikely
	* 		to throws exception as none member is allows to access library without issue_card. /
	def get_members_id()
		begin
			f = File.open('ruby/members.txt', 'r')
			while line = f.gets
				line = line.delete("\n")
				raw = line.split(",")
				if(@name.delete(' ').downcase.eql?(raw[1].delete(' ').downcase))
					return raw[0].delete(' ')
				end	
			end
			raise "The member's name " + name + " does not match with our system!"
		rescue Exception => e
			return e.to_s
		end		
	end
end
/
* class Member below assigns accessibility as a private 
* for instanc variable called name, library and ids. 
* It also assigns accessibility as a private for method called delete_books_from_file 
*/
class Member
	private :delete_books_from_file
	private :name
	private :library 
	private :ids
end
/
* Class Library is a master class that communicate with other classes inside library.rb file
* It has six instances variable. Two are boolean. One is boolean flag and other one is quit_l. 
* Third instance variable is Calender calender and one instance is string served. Two instances 
* are arrays one contain Book object called inLibrary and second array is Member object called current_member.
* Library class include singleton for the constructor that only one object is created.
*
* The librerian can (Library class) issue a new card for a new member, search for the book in the library, 
* serve member by renting or returning the books to the member who is currently serve. 
* Librarian can also print out overdue books and can check out if current member 
* who is served if he-she does not overdue book and print out which books members book.
*
*
* @author David Sajdl
* @username dsajdl01
* @version 10-01-2015
*
*/
class Library

	include Singleton
	#initialize instance variables
	attr_reader :calender, :flag, :inLibrary, :current_member, :served, :quit_l
	/
	* Constracter where instance variables are assigned values
	* 
	* Constracter may receive exception "No such file or directory if any .txt file"
	* If the file is not found
	*/
	def initialize()
		begin
			f = openFileReadable('ruby/collection.txt')
			mem_l = openFileReadable("ruby/lending.txt")
			mem = openFileReadable("ruby/members.txt")
			@inLibrary = []
			@flag = false
			@quit_l = set_quit()
			@current_member = []
			@calender = Calender.instance
			@served = nil
			set_library(f)
			current_members_of_the_library(mem)
			set_books_due_days(mem_l)
		rescue Exception => e
			puts  "Sorry: " + e.message
		end
	end

	/
	* open() method opens the library by setting flag to true  
	* 
	* @ruturn string text "Today is the day" and current day
	* @throws exception if the library is already open. "The library is already open!"
	* @throws exception if the library is closed for renovation "The library is now closed for renovation."
	* /
	def open()
		begin
			if(@quit_l == false)
				raise "The library is now closed for renovation."
			end
			if(@flag == true)
				raise "The library is already open!"
			else
				@flag = true
				today = calender.get_date()
				return "Today is the day " + today
			end
		rescue Exception => e
			return e.message
		end
	end

	/
	* issue_card() method assigns a new member card for a new member. If the name is already exist 
	* in the system it return that member already has a card otherwise return card is issued.
	* Method may receive exception "No such file or directory if any .txt file" if members.txt file is not found
	*
	* @param string a name that would be a new member of the library
	* @return string either Library card issued to member or member already has a library card
	* @throws exception if the library is not open. "The library is not open!"
	* /
	def issue_card(name_of_member)
		begin
			if(@flag == false)
				raise "The library is not open."
			else
				if(check_member_if_exist(name_of_member))
					return name_of_member + " already has a library card"
				elsif(current_member.size == 0)
					add_new_member_into_file(name_of_member)
					current_member[0] = Member.new(name_of_member,nil)
					return "Library card issued to " + name_of_member
				else
					add_member_into_file(name_of_member)
					index = current_member.size
					current_member[index] = Member.new(name_of_member,nil)
					return "Library card issued to " + name_of_member
				end
			end
		rescue Exception => e
			return e.message
		end
	end
	/ serve() method specify which member is being to be served and if member who is
	* served has borrowed the books. Serve method also prints out the books that member borrowed  
	*  
	* 
	* @param string members name who will be served
	* @return string either "Now serving member name " or "member name does not have a library card"
	* @throws exception if the library is not open. "The library is not open!"/
	def serve(name_of_member)
		begin
			if(@flag == false)
				raise "The library is not open."
			else
				if(check_member_if_exist(name_of_member))
					@served = name_of_member
					borrow_books = is_borrowed()
					if(borrow_books != [])
						num = borrow_books.size()
						if(num == 1)
							message = num.to_s + " book"
						else
							message = num.to_s + " books"
						end
						puts @served + " has already borrowed: " + message
						puts borrow_books
					end
					return "Now serving " + name_of_member + "."
				else
					return name_of_member + " does not have a library card."
				end
			end
		rescue Exception => e
			return  e.message
		end
	end
	/
	* is_serve() method returns member who is currently served 
	*
	* @return string that represents members who is currently serve
	*/
	def is_serve()
		return @served
	end
	/
	* set_serve method deletes current member who is serve or in other words sets instance variable called served to null
	*/
	def set_serve()
		@served = nil
	end
	/
	* is_borrowed method checks if member who is currently serve has borrowed any books
	* 
	* @return string array that represents the books that serve member borrowed 
	*	 or if member does not borrowed any book it returns empty array
	*/
	def is_borrowed()
		index = get_members_reference()
		books = []
		b_i = 0
		i = 0
		while(i < current_member[index]. get_books().size)
			if(current_member[index].get_books[i] != nil)
				books[b_i] = current_member[index].get_books[i].to_s
				b_i = b_i + 1
			end
			i = i + 1
		end
		return books
	end
	/
	* find_overdue_books() method prints out the books that are overdue by the member who is currently serve.
	* If serve member does not have any overdue books it prints "None".
	*
	*
	* @throws exception if the library is not open. "The library is not open!"
	* @throws exception "No member is currently being served." if none member is served /
	def find_overdue_books()
		begin
			if(@flag == false)
				raise "The library is not open."
			elsif @served == nil
				raise "No member is currently being served."
			else
				index = get_members_reference()
				overdue_message = []
				overdue_message[0] = served + " overdue books:"
				b_i = 0
				while (b_i < current_member[index]. get_books().size)
						if(current_member[index].get_books[b_i] != nil)
							str_due_date = current_member[index].get_books[b_i].get_due_date().to_s()
							time_due_day = Time.parse(str_due_date)
							if(calender.count_diff_between_today(time_due_day) > 0 )
								indx = overdue_message.length
								overdue_message[indx] = current_member[index].get_books[b_i].to_s
							end
						end
					b_i =  b_i + 1
				end

				if(overdue_message.length != 1)
					return overdue_message.each	{|e| puts e}
				else
					return "None"
				end
			end
		rescue Exception => e
			 return e.message
		end
	end


	/
	* find_all_overdue_books() method prints all member who overdue books with book id and names.
	* If there are not overdue books then it prints "NO books are overdue" 
	*
	* @throws exception if the library is not open. "The library is not open!"/
	def find_all_overdue_books()
		begin
			if(@flag == false)
				raise "The library is not open."
			 else
				text = 	"NO books are overdue."	
				i = 0
				zero = true
				overdue_mem = []
				i_overdue = 0
				while(i < current_member.size)
					overdue_members = current_member[i].send_over_notice("OVERDUE BOOK!")
					i = i + 1
					if(not(overdue_members.include?(text)))
						overdue_mem[i_overdue] = overdue_members
						i_overdue = i_overdue + 1
						zero = false
					end
				end
				if(zero)
					return text
				else
					overdue_mem.each {|e| puts e}
				end 
			end
		 rescue Exception => e
			return  e.message
		end
	end
	/
	* check_in() methods allows member who is served to return or give back the books 
	* Methods checks if the book's ids are borrowed by the memeber who is currently served
	* if yes method return the books and print out a message the book is return. If the book's id does not appear in the library
	* print out "The library does not have book id". If the book's id match with system but the book was not borrowed by
	* serving member it prints out the member does not have book id. 

	* @param  string or integer array of the book's that member want to return 
	* @throws exception if the library is not open. "The library is not open!"
	* @throws exception "No member is currently being served." if none member is served /
	def check_in(*book_ids)
		begin
			index_book = 0
			message = []
			mesg_i = 0
			while(index_book < book_ids.length)
				bk_id = book_ids[index_book].to_s
				if(@flag == false)
					raise "The library is not open."
				elsif(@served == nil)
					raise "No member is currently being served."
				elsif (0 > get_book_reference(bk_id))
					message[mesg_i] = "The library does not have book's id: " + bk_id + "."
					mesg_i = mesg_i + 1
				else
					index = check_if_member_lend_book(bk_id)
					if(index != nil)
						book_ind = get_membersBook_index(index, bk_id)
						return_book = current_member[index].get_books[book_ind]
						current_member[index].give_back(return_book)
						message[mesg_i] = @served + " has returned the book; " + return_book.to_s
						mesg_i = mesg_i + 1
					else
						message[mesg_i] = "The member " + served + " does not have " + bk_id
						mesg_i = mesg_i + 1
					end
				end
				index_book = index_book + 1
			end
			return message.each {|e| puts e}
		rescue Exception => e
			return e.message
		end
	end
	/
	* get_membersBook_index() private method searchs for the book's index
	* by going through members books and when the book is found it returns index of the book.
	*
	* @param integer that is index of current_member that represent member who is currently serve
	* @param string book's id that represent book's id that member wants to return
	* @throws an exception if the index of the book is not found, however it is unlikely that the exception would be 
	* thrown as the previous check is done by method check_if_member_lend_book() */
	def get_membersBook_index(i, id)
		ind = 0
		while( ind < current_member[i].get_books().length)
			if (current_member[i].get_books[ind] != nil)
				if(current_member[i].get_books[ind].get_id().eql?(id))
					return ind
				end
			end
			ind = ind + 1
		end
		raise "Search for book id is out of boundry "
	end
	/
	* check_if_member_lend_book() private method checks if the book's id is borrowed by the member who is currently served.
	*
	* @param string book's id that represents book's id that members wants to return
	* @return either integer the index of the member who is currently served and  
	* who borrows a book (book's id) or it returns null /
	def check_if_member_lend_book(book_ids)
		i = 0
		while (i < current_member.size)
			mem_ind = 0
			while(mem_ind < current_member[i].get_books().length)
				if(current_member[i].get_books[mem_ind] != nil)
					if(current_member[i].get_books[mem_ind].get_id().delete(' ').eql?(book_ids) && 
						served.delete(' ').eql?(current_member[i].get_name().delete(' ')) &&
						current_member[i].get_books[mem_ind].get_due_date() != (nil))
						return i
					end
				end
				mem_ind = mem_ind + 1
			end
			i = i + 1
		end
		return nil
	end

	/
	* search() method searchs through the library books, which was not borrowed 
	* such as book's id, title or author,
	* If the book contains the text that is pass with method arguments it prints out the books. 
	* If the text do not match with any books it prints out 'No book found.'
	*
	* @param string that is a key word for which would be searched
	* @return either string "The search string must contain at least four characters." if the length of the 
	* argument is smaller than 4 characters or array that holda books that contains key word from passing argument
	* @throws exception if the library is not open. "The library is not open!" /
	def search(string)
		begin
			string = string.to_s
			if(@flag == false)
				raise "The library is not open."
			end
			if(string.length < 4)
				return "The search string must contain at least four characters."
			else
				message = get_book(string)
				if(message.class == String)
					return message
				else
					i = 0
					mess = []
					mesg_i = 0
					while(i < message.length)
						if(inLibrary[message[i]].get_due_date() == nil)
							mess[mesg_i] = inLibrary[message[i]].to_s
							mesg_i = mesg_i + 1
						end
						i = i + 1
					end
					return mess.each {|e| puts e}
				end
			end
		rescue Exception => e
			return e.message
		end
	end
	/
	* check_in() methods allows member who is currently served to borrow the books. 
	* Methods checks if the book's ids are in the library if yes and book is not borrow by someone
	* and member does not borrow already 3 books than, method prints the book has been checked out. 
	* If the book's ids are not in the libarry  
	* it prints out "The library does not have book id" or if the book is already borrowed 
	* it prints out The book is already lended.
	* 
	* @param string or integer array as a book's ids that member who is currently serve wants to borrow
  	* @throws exception if the library is not open. "The library is not open!"
	* @throws exception "No member is currently being served." if none member is served  /
	def check_out(*book_ids)
		begin
			index_book = 0
			message = []
			mesg_i = 0
			count = 0
			while(index_book < book_ids.length)
				bk_id = book_ids[index_book].to_s()
				if(@flag == false)
					raise "The library is not open."
				elsif(@served == nil)
					raise "No member is currently being served."
				else
					index = get_book_reference(bk_id)
					if (0 > index)
						message[mesg_i] = "The library does not have book " + bk_id + "."
						mesg_i = mesg_i + 1
					else
						if(inLibrary[index].get_due_date() == nil)
							inLibrary[index].check_out(calender.advance())
							mem_index = get_members_reference()
							current_member[mem_index].check_out(inLibrary[index])
							add_book_into_lending_file(current_member[mem_index].get_members_id(), inLibrary[index].get_id(), calender.advance().to_s())
							message[mesg_i] = inLibrary[index].to_s() + " book has been checked out to " + served + "."
							mesg_i = mesg_i + 1
							if(count < 3)
								count = count + 1
							else
								message[mesg_i] = @served + " has already borrowed 3 books!"
								mesg_i = book_ids.length + 1
							end
						else
							message[mesg_i] = "The book with id: " + bk_id + "is already lended."
							mesg_i = mesg_i + 1
						end
					end
				end
				index_book = index_book + 1
			end
			return message.each {|e| puts e}
		rescue Exception => e
			return e.message
		end

	end
	/
	* get_members_reference() private method searchs search for index of the serve member 
	* by going through the instance variavle called current_member array 
	* and when the member who is currently served is found in the array it returns index.
	*   
	* @throw exception if the member is not found however it is unlikely that the exception would be thrown
	* as serve members is alteady checked inside serve() method by check_member_if_exist(). /
	def get_members_reference()
		i = 0
		while (i < current_member.size)
			if(current_member[i].get_name().eql?(@served))
				return i
			end
			i = i + 1
		end
		raise "Member does not appear in the library."
	end
	/
	* renew() method  allows memeber who is currently served to renew the books that member borrowed. 
	* If book's id match with list of books that member has borrowed, the book is renewed by 
	* setting due day 7 days ahead and print out "book has been rewened for membet until date". 
	* If the book's id does appear in the libary it prints our "The library does not have book id". If the book's id 
	* appear in the library but is not lended by the served member it prints out "The member does not have book id".
	*
	* @param array as string or integer that represents the book's id that members wants to renew 
  	* @throws exception if the library is not open. "The library is not open!"
	* @throws exception "No member is currently being served." if none member is served /
	def renew(*book_ids)
		begin
			index_book = 0
			message = []
			mesg_i = 0
			while(index_book < book_ids.length)
				bk_id = book_ids[index_book].to_s
				if(@flag == false)
					raise "The library is not open."
				elsif(@served == nil)
					raise "No member is currently being served."
				elsif (0 > get_book_reference(bk_id))
					message[mesg_i] = "The library does not have book " + bk_id + "."
					mesg_i = mesg_i + 1
				else
					index = check_if_member_lend_book(bk_id)
					if(index != nil)
						book_ind = get_membersBook_index(index, bk_id)
						renew_book = current_member[index].get_books[book_ind].to_s()
						current_member[index].get_books[book_ind].check_out(calender.advance())
						renew_until = current_member[index].get_books[book_ind].get_due_date()
						renew_book_in_the_file(current_member[index].get_members_id(), current_member[index].get_books[book_ind].get_id(), renew_until.to_s())
						message[mesg_i] = renew_book + " book has been rewened for " + served + " unit: " + renew_until.strftime("%d-%m-%Y")
						mesg_i = mesg_i + 1
					else
						message[mesg_i] = "The member " + served + " does not have " + bk_id
						mesg_i = mesg_i + 1
					end
				end
				index_book = index_book + 1
			end
			return message.each { |e| puts e} 
			rescue Exception => e
				return e.message
		end
	end
	/
	* renew_book_in_the_file() private method allows to search through lending txt file 
	* and renew book's due date by matching member's id and book's id.
	*
	* @param string member' id that is memberd' id who is currently served.
	* @param string book's id that is book's  id that member borrowed and wish to renew.
	* @param string date that represents date when the rewen book should be returned.
	* @throws No such file or directory if txt file is not found, if lending.txt file is not found./
	def renew_book_in_the_file(mem_id, book_id, date)
		messabe_to_add = ""
		f = openFileReadable("ruby/lending.txt")
		while line = f.gets
			arr = line.split(',')
			m_id = arr[0].strip
			b_id = arr[1].strip
			if(mem_id.eql?(m_id) && book_id.eql?(b_id))
				messabe_to_add = messabe_to_add + mem_id + ", " + book_id + ", " + date + "\n"
			else
				messabe_to_add = messabe_to_add + line
			end
		end
		f_w = File.open("ruby/lending.txt", "w")
		f_w << messabe_to_add
		f_w.close()
	end	
	/
	* close() method allows to shut down the library by changing value of flag to false and prints out "Good night"
	* 
	* @throws exception if the library is not open. "The library is not open." /
	def close()
		begin
			if(@flag == false)
				raise "The library is not open."
			end
			@flag = false
			return "Good night"
		rescue Exception => e
			return e.message
		end
	end
	/
	* quit() method assign instance variables flag and quit_l to false and return "The library is now closed for renovation"
	* 
	* @return string "The library is now closed for renovation" /
	def quit()
		@quit_l = false
		@flag = false
		return "The library is now closed for renovation."
	end
	/
	* set_quit() method opens the library after the renovation by setting 
	* instance variable quit_l to true;
	*/
	def set_quit()
		@quit_l = true		
	end
	/
	* get_book() private method allows to search through, "array inLibrary instance variable that holds library's books", 
	* all the books in the library and if the string contain the same content as the book and book is not borrowed by any member it add books into array and return the array.
	* 
	* @param string that contain any key word that member wish to search for through library books
	* @return either array of integers that represent index of the books that contain word from the argument or 
	*	string that non of the books was found "No book found" /
	def get_book(string)
			str = string.delete(" ").downcase
			index = 0
			i = 0
			message = []
			found = false
			while index < inLibrary.size
				to_add = false 
				raw = inLibrary[index]
				raw = raw.to_s
				raw = raw.downcase
				if(raw.include?(str) && inLibrary[index].get_due_date() == nil)
					found = true
					if(i == 0)
						message[i] = index
						i = i + 1 
					else
						to_add = check_if_book_exist(message, index)
					end	
				end
				if(to_add)
					message[i] = index
					i = i + 1
				end
				index = index + 1
			end
			if(found)
				return message
			end
		return 'No book found.'
	end
	/
	* check_member_if_exist() private method checks if the book exist in the array "list" when 
	* the method search() search for the book by comparing books title and author if the array holds same
	* books with book the the array that is pass with parameter it returns false otherwise true
	* 
	* @param array message that holds indexes of the library's book
	* @param integer index that represent search book's index
	* @return boolean either true if the books does not match with array or false if the array holds the book  
	*/
	def check_if_book_exist(message, index)
	check_i = 0
		while(check_i < message.size)
			val = message[check_i]
			if(((inLibrary[val].get_title.eql?(inLibrary[index].get_title)) &&
			 (inLibrary[val].get_author.eql?(inLibrary[index].get_author))))
				return false
			end
			check_i = check_i + 1
		end
		return true
	end
	/
	*check_member_if_exist() private method check if the member exist in the system by
	* searchs through the list of members who have member card 
	* and check if argument name match with the members in the list.
	*
	* @param string name that represent members name.
	* @return boolean either true member is found or false member is not found /
	def check_member_if_exist(name_of_member)						
			i = 0
			while (i < current_member.size)
				if(current_member[i].get_name().delete(' ').downcase().eql?(name_of_member.delete(' ').downcase()))
					return true
				end
				i = i + 1
			end
		return false
	end
	/
	* set_library() private method allows to read a file and add books as an object into array inLibrary
	*
	* @param file that is opened collection.txt file /
	def set_library(f)
		i = 0
		id = 1001
			while line = f.gets
				line = line.delete("\n")
				the_book = line.split(",")
				@inLibrary[i] = Book.new(id.to_s, the_book[0].strip, the_book[1].strip)
				i = i + 1
				id = id + 1
			end
	end
	/
	*current_members_of_the_library() private method allows
	* to read a file and add members as a object into array current_member
	*
	* @param file that is opened members.txt file /
	def current_members_of_the_library(f)
		i = 0
		while line = f.gets
			line = line.delete("\n")
			arr = line.split(',')
			current_member[i] = Member.new(arr[1].strip, nil)
			i = i + 1
		end
	end
	/
	* set_books_due_days() private method allows
	* to read through the file and set due date of the borrow books.
	* 
	* @param file that is opened lending.txt file /
	def set_books_due_days(f)
		i = 0
		while line = f.gets
			line = line.delete("\n")
			arr = line.split(',')
			index = 0
			while (index < current_member.size())
				if(current_member[index].get_members_id.eql?(arr[0].delete(' ')))
					book_Index = get_book_reference(arr[1].delete(' '))
					inLibrary[book_Index].check_out(arr[2].strip)
					current_member[index].check_out(inLibrary[book_Index])
				end
				index = index + 1
			end
		end		
	end
	/
	* get_book_reference() private method search through the library books 
	* and when the book's id match with the passing argument book's id, it returns index of the book.
	*
	* @param string that represents book's id
	* @return integer either index of the book if the book's id is found 
	* 		  or -1 if the book's id does not match with any library books /
	def get_book_reference(id)
		i = 0
		while (i < inLibrary.size())
			if(inLibrary[i].get_id.eql?(id))
				return i
			end
			i = i + 1
		end
		return -1
	end
	/
	* add_book_into_lending_file() private method opens lending.txt file 
	* and add all passing arguments as a string into lending.txt file.
	* New string is added as a new line at the end of the file.
	*
	* @param string id that represent member's id
	* @param string bookid that represents book's id thta member is borowing
	* @param date due_date that represents date when the the borrowed book must be returned 
	* @throws No such file or directory if txt file is not found, if lending.txt file is not found./
	def add_book_into_lending_file(id, bookid, due_date)
		lending_book = id.to_s + ", " + bookid.to_s + ", " + due_date.to_s + "\n"
		f = File.open("ruby/lending.txt", "a+"){|f| f << lending_book} 
	end
	/
	* openFileReadable() private method allows to open any file as readable and return it.
	*
	* @param string that represents path to the file (.txt) 
	* @return File.open() that is open file as readable. /
	def openFileReadable(file) 
		return File.open(file, 'r')
	end
	/
	* add_member_into_file() private method creates new member id with 
	* passing argument member's name add them into members.txt file
	*
	* @param string member_name that represents member's name
	* @throws No such file or directory if txt file is not found, if members.txt file is not found. /
	def add_member_into_file(member_name)
		str = get_three_char_of_name(member_name)
		num = get_last_id()
		num = num + 1
		id = str + num.to_s
		name_with_id = id + ", " + member_name + "\n"
		f = File.open("ruby/members.txt","a+"){|f|  f << name_with_id}
	end
	/
	* add_new_member_into_file() private method creates new member id and with 
	* passing argument member's name add them into members.txt file. This method is 
	* called only once when there are not any members in the file or the the library.
	* Method is called only once when non of the member exist in the list.
	*
	* @param string member_name that represents member's name.
	* @throws No such file or directory if txt file is not found, if members.txt file is not found. /
	def add_new_member_into_file(name)
		str = get_three_char_of_name(name)
		id = str + "1000"
		name_with_id = id + ", " + name + "\n"
		f = File.open("ruby/members.txt","a+"){|f|  f << name_with_id}
	end
	/
	* get_last_id() private method allows to get last id that was assign to the member 
	* Then add 1 to last id and return new id
	*
	* @return integer idStrNum that represent new membre's id. /
	def get_last_id()
		i = current_member.size
		i = i - 1 
		member_id = current_member[i].get_members_id()
		idStrNum = member_id[3,member_id.length]
		return idStrNum.to_i
	end
	/ 
	* get_three_char_of_name() private method allows to take first 
	* three characters of the name and return them
	*
	* @param string name that represent member's name
	* @return  string three_char that is first three characters of member's name /
	def get_three_char_of_name(name)
		n = name.delete(' ').downcase
		while(n.length < 3)
			n = n + "x"
		end
		three_char = n[0,3]
		return three_char.capitalize!
	end
end
/
* class Library below assigns accessibility as a private for instance variables. 
* It also assigns accessibility as a private for methods 
*/
class Library
	# instance variables
	private :calender
	private :current_member
	private :flag
	private :inLibrary 
	private :served
	private :quit_l
	# methods
	private :add_book_into_lending_file
	private :add_member_into_file
	private :add_new_member_into_file
	private :check_if_book_exist
	private :check_if_member_lend_book
	private :check_member_if_exist
	private :current_members_of_the_library
	private :get_book
	private :get_book_reference
	private :get_last_id
	private :get_membersBook_index
	private :get_members_reference
	private :get_three_char_of_name
	private :openFileReadable
	private :renew_book_in_the_file
	private :set_books_due_days
	private :set_library
end