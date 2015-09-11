require_relative "code_test_DavidSajdl"
gem 'test-unit'
require "test/unit"

/
* Class TestMyMatch allows to unit test on MyTest class 
* from the code_test_DavidSajdl.rb file
* 
* @author David Sajdl
* @version 27_08_2015
*
* /

class TestMyMatch < Test::Unit::TestCase

	def setup
		@mt = MyMatch.new
		@text = "Polly put the kettle on, polly put the kettle on, polly put the kettle on we'll all have tea"
		
		@Subtext = "Polly"
		@Subtext1 = "polly"
		@Sub_Output =  [1, 26, 51]
		
		@Subtext2 = "ll"
		@Subtext3 = "Ll"
		@Sub_Output2 = [3, 28, 53, 78, 82]

		@Subtext4 =  "X"
		@Subtext5 = "Polx"
		@Sub_Output4 = "<no matches>"
	end

	def test_get_match_subString
		assert_equal(@Sub_Output, @mt.get_match_subString(@text, @Subtext))
		assert_equal(@Sub_Output, @mt.get_match_subString(@text, @Subtext1))
		assert_equal(@Sub_Output2, @mt.get_match_subString(@text, @Subtext2))
		assert_equal(@Sub_Output2, @mt.get_match_subString(@text, @Subtext3))
		assert_equal(@Sub_Output4, @mt.get_match_subString(@text, @Subtext4))
		assert_equal(@Sub_Output4, @mt.get_match_subString(@text, @Subtext4))
	end	

	def test_get_match_subStringII
		output = [3, 4, 19, 28, 29, 44, 53, 54, 69, 78, 79, 82, 83]
		assert_equal(output, @mt.get_match_subString(@text, "l"))
		assert_equal(output, @mt.get_match_subString(@text, "L"))
		output = [20, 45, 70]
		assert_equal(output, @mt.get_match_subString(@text, "e o"))
		output =  [90]
		assert_equal(output, @mt.get_match_subString(@text, "tea"))
		output = [81, 86, 92]
		assert_equal(output, @mt.get_match_subString(@text, "a"))
		output = [1, 7, 26, 32, 51, 57]
		assert_equal(output, @mt.get_match_subString(@text, "p"))
		output = [11, 36, 61]
		assert_equal(output, @mt.get_match_subString(@text, "the"))
		
	end 

	def test_get_match_subStringIII
		assert_equal(@Sub_Output4, @mt.get_match_subString(@text, ""))
		textII = @text + @text 
		assert_equal(@Sub_Output4, @mt.get_match_subString(@text, textII))
		assert_equal(@Sub_Output4, @mt.get_match_subString(@text, 534))
		output = [3]
		assert_equal(output, @mt.get_match_subString(123456789, 345))
		output = [6, 10, 14, 21, 25, 31, 35, 39, 46, 50, 56, 60, 64, 71, 74, 80, 84, 89]
		assert_equal(output, @mt.get_match_subString(@text, " "))
	end

	def test_get_match_subStringIV
		assert_equal(@Sub_Output4, @mt.get_match_subString(@text, nil))
		assert_equal(@Sub_Output4, @mt.get_match_subString(nil, " "))
		assert_equal(@Sub_Output4, @mt.get_match_subString(nil, nil))
		assert_equal(@Sub_Output4, @mt.get_match_subString("", " "))
		assert_equal(@Sub_Output4, @mt.get_match_subString("", ""))
		assert_equal(@Sub_Output4, @mt.get_match_subString(" ", ""))
		output = [1]
		assert_equal(output, @mt.get_match_subString(" ", " "))
	end
end
