require_relative "library"
gem 'test-unit'
require "test/unit"
/
* Class TestCalender allows to test Calender class 
* from the library.rb file
* 
* @author David Sajdl
* @username dsajdl01
* @version 10-01-2015
*
* /
class TestCalender < Test::Unit::TestCase
	require 'time'
	/
	*self.test_order insure that methods inside TestCalender class are tested by alphabetical order
	*/
	self.test_order = :alphabetic
	/
	* setup is called before every single test inside TestCalender class is tested
	* and it sets instance variables
	*/
	def setup
		@day = Time.now
		@seven_day = @day + (2*7*12*60*60)
		@strd = @day.strftime("%d-%m-%Y")
		@cal = Calender.instance
	end
	/
	* testing Throwing Exceptions in the methods count_diff_between_today() and advance()
	*/	
	def test_a_Throwing_Exceptions
		assert_raise( RuntimeError ) { @cal.count_diff_between_today(@seven_day) }
		assert_raise( RuntimeError ) { @cal.advance()}
		
	#	assert_equal(seven_day, Calender.instance.advance())
	#	assert_equal(day, Calender.instance.get_today_date())
	end
	/
	* testing get_date method 
	*/
	def test_b_get_date
		assert_equal(@strd, @cal.get_date())
	end
	/
	* testing count_diff_between_today method 
	*/
	def test_c_count_diff_between_today
		@cal.get_date()
		assert_equal(-7, @cal.count_diff_between_today(@seven_day))
	end
end




/
* Class TestBook allows to test Book class 
* from the library.rb file
* 
* @author David Sajdl
* @username dsajdl01
* @version 10-01-2015
*
* /
class TestBook < Test::Unit::TestCase
	/
	*self.test_order insure that methods inside TestCalender class are tested by alphabetical order
	* 
	*/
	self.test_order = :alphabetic
	/
	* setup is called before every single test is tested inside TestBook class 
	* and it sets instance variables
	*/
	def setup
		@id = "1002"
		@title = "Seven Languages in Seven Weeks"
		@author = "Frederic Daoud"
		@book = Book.new(@id, @title, @author)
	end
	/
	* testing book_id method
	*/
	def test_d_book_id
		assert_equal(@id, @book.get_id())
		assert_not_equal("1001", @book.get_id())
	end
	/
	* testing book_title method
	*/
	def test_e_book_title
		assert_equal(@title, @book.get_title())
	end
	/
	* testing book_author method
	*/
	def test_f_get_author
		assert_equal(@author, @book.get_author())
	end
	/
	* testing get_due_date method
	*/
	def test_g_get_due_date
		assert_nil(@book.get_due_date())
	end
	/
	* testing check_out method
	*/
	def test_h_check_out
		day = Time.now()
		@book.check_out(day)
		assert_not_nil(@book.get_due_date())
		assert_equal(day, @book.get_due_date())
	end
	/
	* testing check_in method
	*/
	def test_i_check_in
		@book.get_check_in()
		assert_nil(@book.get_due_date())
		assert_equal(nil, @book.get_due_date())
	end
	/
	* testing to_s methods
	*/
	def test_j_to_s
		excepting = "Id: 1002 Title: Seven Languages in Seven Weeks by author: Frederic Daoud"
		not_excepting = "Ids: 1002 Title: Seven Languages in Seven Weeks by author: Frederic Daoud"
		assert_equal(excepting, @book.to_s())
		assert_not_equal(not_excepting, @book.to_s())
	end
end
/
* Class TestMember allows to test Member class 
* from the library.rb file
* 
* @author David Sajdl
* @username dsajdl01
* @version 10-01-2015
*
* /
class TestMember < Test::Unit::TestCase
	/
	*self.test_order insure that methods inside TestCalender class are tested by alphabetical order
	*
	*/
	self.test_order = :alphabetic
	/
	* setup is called before every single test inside TestMember class is tested
	* and it sets instance variables
	*/
	def setup
		@all_members = get_all_members_from_the_file()
		add_member_into_file("Saj1000, Sajdl David")
		@book1 = Book.new("1002","Seven Languages in Seven Weeks", "Frederic Daoud")
		@book2 = Book.new("1003", "The Castle", "Frank Kafka")
		@book3 = Book.new("1004", "The God Delusion", "Richard Dawkings")
		@day = Time.now()
		@book1.check_out(@day.to_s)
		@book2.check_out(@day.to_s)
		@book3.check_out(@day.to_s)
		@arr = [nil, nil, nil]
		@member = Member.new("Sajdl David", nil)
	end
	/
	* teardown is called after every single test inside TestMember class is tested 
	* and it adds data back to the file from variable all_members
	*/
	def teardown()
	add_back_members_to_the_file(@all_members) 
	end
	/
	* testing get_name method
	*/
	def test_k_get_name	
		assert_equal("Sajdl David", @member.get_name())
	end
	/
	* testing get_memberId  method
	*/
	def test_l_get_memberId
		assert_equal("Saj1000", @member.get_memberId())
	end
	/
	* testing get_books method
	*/
	def test_m_books
		assert_equal(@arr, @member.get_books())
	end
	/
	* testing check_out method
	*/
	def test_n_check_out
		@member.check_out(@book1)
		@arr[0] = @book1
		assert_equal(@arr, @member.get_books())
		@arr[1] = @book2
		@member.check_out(@book2)
		assert_equal(@arr, @member.get_books)
		@arr[2] = @book3
		@member.check_out(@book3)
		assert_equal(@arr, @member.get_books)
		assert_raise( RuntimeError ) {@member.check_out(@book1)}
		assert_equal(@arr, @member.get_books)
	end
	/
	* testing give_back method
	*/
	def test_o_give_back
		@member.give_back(@book2)
		@arr[1] = nil
		assert_equal(@arr, @member.get_books)
		assert_nil(@member.get_books[1])
		assert_not_nil(@member.get_books[0].to_s)
	end
	/
	* testing send_over_notice method
	*/
	def test_p_send_over_notice
		c =  Calender.instance
		c.get_date
		excepting =  "Sajdl David NO books are overdue."
		assert_equal(excepting, @member.send_over_notice("notice"))
		assert_equal(@arr, @member.get_books)
		eight_seven_day = @day - (2*7*14*60*60)
		@book2.check_out(eight_seven_day.to_s)
		@member.check_out(@book2)
		String excepting2 =	["Sajdl David notice 1003 The Castle"]
		assert_equal(excepting2, @member.send_over_notice("notice"))
	end
	/
	* testing get_members_id method
	*/
	def test_q_get_members_id
		assert_equal("Saj1000", @member.get_members_id)
		m = Member.new("Richard Dawkings", nil)
		message = "The member's name Richard Dawkings does not match with our system!"
		assert_equal(message, m.get_members_id)
	end
	/
	* get_all_members_from_the_file method gets all data 
	* from members.txt file and return them back and set members.txt up empty
	*
	* @return string all data from members.txt file
	*/
	def get_all_members_from_the_file()
		f = File.open("ruby/members.txt", 'r')
		all_books = ""
		while line =  f.gets
			all_books = all_books + line
		end
		update = File.open("ruby/members.txt", 'w')
		update << ""
		update.close
		return all_books
	end
	/
	* add_back_members_to_the_file method adds 
	* members from parameter back to members txt file
	*
	* @param string member of the library with id and name 
	*/
	def add_back_members_to_the_file(members)
		update = File.open("ruby/members.txt", 'w')
		update << members
		update.close
	end
	/
	* add_two_members_into_file method adds two 
	* names from paramet to members txt file
	*
	* @param string member of the library with id and name  
	* @param string member of the library with id and name 
	*/
	def add_member_into_file(name)
		update = File.open("ruby/members.txt", 'w')
		message = name + "\n"
		update << message
		update.close
	end
end
/
* Class TestLibrary allows to test Calender class 
* from the library.rb file
* 
* @author David Sajdl
* @username dsajdl01
* @version 10-01-2015
*
* /
class TestLibrary < Test::Unit::TestCase
		/
		*self.test_order insure that methods inside TestLibrary class are tested by alphabetical order
		*/
		self.test_order = :alphabetic
		/
		* setup is called before every single test inside TestLibrary class is tested
		* It sets instance variables,
		* it also loads all save data from the files lending and members txt
		* and seve them into the variables called all_borrowed_book and all_members
		*/
		def setup()
			@name = "Sajdl David"
			@overdue_mem = "Mazurek Magdalena"
			@all_borrowed_book = get_all_borrowed_books()
			@all_members = get_all_members_from_the_file()
			add_two_members_into_file( "Saj1000, "+ @name, "Maz1001, "+ @overdue_mem)
			add_overdue_book_to_member("Maz1001, 1001, 2014-12-16 20:15:36 +0000")
			@list = Library.instance
			@open =  "The library is not open."
			
		end 
		/
		* teardown is called after every single test inside TestLibrary class is tested 
		* and it adds data back to the file from variables all_borrowed_book and all_members
		*/
		def teardown()
			add_back_books_to_the_file(@all_borrowed_book)
			add_back_members_to_the_file(@all_members)
		end
		/
		* testing open method
		*/
		def test_r_open
			d = Time.now
			except = "Today is the day " + d.strftime("%d-%m-%Y") 
			assert_equal(except, @list.open())
			assert_equal("The library is already open!", @list.open())
			@list.close()
		end
		/
		* testing clese method
		*/
		def test_s_close
			@list.open
			assert_equal("Good night",@list.close())
			assert_equal(@open, @list.close())
		end
		/
		* testing issue_card method
		*/
		def test_t_issues_card
			@list.close
			assert_equal(@open, @list.issue_card(@name))
			@list.open
			assert_equal(@name + " already has a library card", @list.issue_card(@name))
			new_name = "Delaney Bob"
			assert_equal"Library card issued to " + new_name, @list.issue_card(new_name)
			@list.close
		end
		/
		* testing find_overdue_books method
		*/
		def test_u_find_overdue_books
			@list.close
			assert_equal(@open, @list.find_overdue_books())
			@list.open()
			@list.set_serve()
			assert_nil(@list.is_serve)
			assert_equal("No member is currently being served.", @list.find_overdue_books())
			@list.serve(@overdue_mem)
			assert_equal(@overdue_mem,@list.is_serve)
			exc = ["Mazurek Magdalena overdue books:", "Id: 1001 Title: The Castle by author: Frank Kafka"]
			assert_equal(exc, @list.find_overdue_books())
			@list.serve(@name)
			assert_equal("None", @list.find_overdue_books())
			@list.close()
		end
		/
		* testing check_out method
		*/
		def test_v_check_out
			@list.close
			assert_equal(@open, @list.check_out(1011))
			@list.open
			@list.set_serve
			assert_equal("No member is currently being served.", @list.check_out(1011))
			@list.serve(@name)
			exp = ["The book with id: 1001is already lended."]
			assert_equal(exp, @list.check_out(1001))
			exp1 = ["Id: 1002 Title: The Castle by author: Frank Kafka book has been checked out to Sajdl David.",
 						"Id: 1003 Title: The Metamorphosis by author: Frank Kafka book has been checked out to Sajdl David.",
 						 "Id: 1004 Title: The Metamorphosis by author: Frank Kafka book has been checked out to Sajdl David."]
			assert_equal(exp1, @list.check_out(1002,"1003",1004))
			exp2 =  @name + " has already borrowed 3 books!"
			assert_equal(exp2, @list.check_out("1005"))
			exp3 = ["The library does not have book 101."]
			assert_equal(exp3, @list.check_out(101))
			e = ["Sajdl David has returned the book; Id: 1002 Title: The Castle by author: Frank Kafka",
 					"Sajdl David has returned the book; Id: 1003 Title: The Metamorphosis by author: Frank Kafka",
 					"Sajdl David has returned the book; Id: 1004 Title: The Metamorphosis by author: Frank Kafka"]					
			assert_equal(e, @list.check_in("1002",1003,"1004"))
			@list.close()
		end
		/
		* testing is_borrowed method
		*/
		def test_va_is_borrowed
				@list.open
				@list.serve(@overdue_mem)
				
				exp = ["Id: 1001 Title: The Castle by author: Frank Kafka"]
				assert_equal(exp, @list.is_borrowed)
				@list.close()
		end
		/
		* testing find_all_overdue_books method
		*/
		def test_w_find_all_overdue_books
			assert_equal(@open, @list.find_all_overdue_books)
			@list.open
			assert_equal("Now serving " + @overdue_mem + ".", @list.serve(@overdue_mem))
			exc = [[@overdue_mem + " OVERDUE BOOK! 1001 The Castle"]]
			assert_equal(exc, @list.find_all_overdue_books)
			@list.check_in(1001)
			assert_equal("NO books are overdue.", @list.find_all_overdue_books)
			@list.close
		end
		/
		* testing open serve
		*/
		def test_x_serve
			@list.close
			assert_equal(@open, @list.serve(@name))
			@list.open
			@list.set_serve()
			assert_nil(@list.is_serve)
			assert_equal("Now serving " + @name + ".", @list.serve(@name))
			assert_equal(@name, @list.is_serve)
			mem_name = "Yukihiro Matsumoto"
			assert_equal(mem_name + " does not have a library card.", @list.serve(mem_name))
			assert_equal(@name, @list.is_serve)
			@list.set_serve()
		end
		/
		* testing renew method
		*/
		def test_y_renew
			@list.close()
			assert_equal(@open, @list.renew(1002))
			@list.open
			@list.set_serve
			assert_equal("No member is currently being served.", @list.renew(1002))
			@list.serve(@name)
			@list.check_out(1002)
			d = Time.now
			d_seven = d +(2*7*12*60*60)
			strd = d_seven.strftime("%d-%m-%Y")
			exp = ["Id: 1002 Title: The Castle by author: Frank Kafka book has been rewened for Sajdl David unit: " + strd]
			assert_equal(exp,@list.renew(1002))
			@list.check_in(1002)
			exp2 = ["The member " + @name + " does not have 1001"]
			assert_equal(exp2,@list.renew(1001))
			exp3 = ["The library does not have book 201."]
			assert_equal(exp3, @list.check_out(201))
			@list.close
		end
		/
		* testing check_in method
		*/
		def test_z_check_in
			@list.close
			assert_equal(@open, @list.check_in(1000))
			@list.open
			@list.set_serve
			assert_equal("No member is currently being served.", @list.check_in(1000))
			@list.serve(@name)
			exp = ["The member Sajdl David does not have 1002",
 					"The member Sajdl David does not have 1003",
 					"The member Sajdl David does not have 1004"]
			assert_equal(exp, @list.check_in(1002,1003,"1004"))
			exp1 = ["The library does not have book's id: 110."]
			assert_equal(exp1, @list.check_in(110))
			exp3 = ["The member Sajdl David does not have 1012"]
			assert_equal(exp3, @list.check_in(1012))
			exp4 = ["Id: 1004 Title: The Metamorphosis by author: Frank Kafka book has been checked out to Sajdl David.", 
				"Id: 1019 Title: The Greatest Show on Earth by author: Richard Dawkings book has been checked out to Sajdl David."]
			assert_equal(exp4, @list.check_out(1004,1019))
			exp5 = ["Sajdl David has returned the book; Id: 1004 Title: The Metamorphosis by author: Frank Kafka", 
				"Sajdl David has returned the book; Id: 1019 Title: The Greatest Show on Earth by author: Richard Dawkings"]
			assert_equal(exp5, @list.check_in(1004,1019))
			@list.close
		end
		/
		* testing search method
		*/
		def test_za_search
			@list.close
			assert_equal(@open,@list.search("Dave"))
			@list.open
			expt = "The search string must contain at least four characters."
			assert_equal(expt, @list.search("Dav"))
			expt1 = ["Id: 1013 Title: The Ancestor's Tale by author: Richard Dawkings"]
			assert_equal(expt1, @list.search("tale"))
			assert_equal("No book found.", @list.search("tele"))
			assert_equal(expt1, @list.search(1013))
			expt2 = ["Id: 1012 Title: The Magic of Reality by author: Richard Dawkings", 
				"Id: 1013 Title: The Ancestor's Tale by author: Richard Dawkings", 
				"Id: 1014 Title: The God Delusion by author: Richard Dawkings", 
				"Id: 1018 Title: The Greatest Show on Earth by author: Richard Dawkings"]
			assert_equal(expt2, @list.search("rich"))
			@list.close
		end
		/
		* testing quit method
		*/
		def test_zb_quit
			assert_equal("The library is now closed for renovation.",@list.quit)
			assert_equal("The library is now closed for renovation.",@list.open)
			assert_equal(true, @list.set_quit())
		end
		/
		* add_overdue_book_to_member() method adds lending book (passing from parameter) back to lending.txt file
		*
		* @param string borrow books  
		*/
		def add_overdue_book_to_member(book_overdue)
			update = File.open("ruby/lending.txt", 'w')
			update << book_overdue
			update.close
		end
		/
		* get_all_borrowed_books method gets all data 
		* from lending.txt file and return them back and set lending.txt up empty
		*
		* @return string all data from lending.txt file
		*/
		def get_all_borrowed_books()
			f = File.open("ruby/lending.txt", 'r')
			all_books = ""
			while line =  f.gets
				all_books = all_books + line
			end
			update = File.open("ruby/lending.txt", 'w')
			update << ""
			update.close
			return all_books
		end
		/
		* get_all_members_from_the_file method gets all data 
		* from members.txt file and return them back and set members.txt up empty
		*
		* @return string all data from members.txt file
		*/
		def get_all_members_from_the_file()
			f = File.open("ruby/members.txt", 'r')
			all_books = ""
			while line =  f.gets
				all_books = all_books + line
			end
			update = File.open("ruby/members.txt", 'w')
			update << ""
			update.close
			return all_books
		end
		/
		* add_two_members_into_file method adds two 
		* names from paramet to members txt file
		*
		* @param string member of the library with id and name  
		* @param string member of the library with id and name 
		*/
		def add_two_members_into_file(name1 , name2)
			update = File.open("ruby/members.txt", 'w')
			message = name1 + "\n" + name2 + "\n"
			update << message
			update.close
		end
		/
		* add_back_members_to_the_file method adds 
		* members from parameter back to members txt file
		*
		* @param string member of the library with id and name 
		*/
		def add_back_members_to_the_file(members)
			update = File.open("ruby/members.txt", 'w')
			update << members
			update.close
		end
		/
		* add_back_books_to_the_file method adds 
		* books that were borrowed back to lending txt file
		*
		* @param string borrowed books as member id, book's id and dueday  
		*/
		def add_back_books_to_the_file(books)
			update = File.open("ruby/lending.txt", 'w')
			update << books
			update.close
		end
end