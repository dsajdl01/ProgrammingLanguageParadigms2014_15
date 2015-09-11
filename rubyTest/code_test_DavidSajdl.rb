/
* Class MyMatch enable to match the subtext against the text 
* 
* @author David Sajdl
* @version 28_08_2015
*
* /

class MyMatch
		/ * constructor /
		def initialize()
		end
		/
		* get_match_subString() method matches the subtext against the text 
		* and returns array of positions if the subtext appear in the text or 
		* no matches string if subtext is not appear in the text
		* 
		* @param text string that represent text 
		* @param subtext string that represent subtext 
		* @return array integers (Fixnum) with positions of subtext that appear in the text or string <no matches> 
		*/
		def get_match_subString(text, subtext)
			/ * if other type values is input, cast to string */
			text = text.to_s()
			subtext = subtext.to_s()
			/ * checking whether subtext length is not zero 
			* or substring length is not greater than text */
			last = len(subtext)
			if(last == 0 || len(text) < last)
				return "<no matches>"
			end
			/ * declaring variables and assigning values */
			index = 0
			i = 0
			found = false
			result = []
			substringIndex = 0
			/ *  loop through the text by using substring and compare whether it's equal to substring */
			while (index < text.length - last +1)
				
				if(swapToLowerCase(text[index]) == swapToLowerCase(subtext[substringIndex]))
						
					/ * if they are equal then store position into array and assign found variable to true */
						if(checkIfSubstringMatch(text, subtext, index, last))
						
						    found = true
							position = index + 1
						#	puts text[index,last] + " in position: " + position.to_s() 
							result[i] = position
							i = i + 1

						end
				end
				index = index + 1
			end
			/ * return correct result */
			if(!found)
				return "<no matches>"
			else
				return  result
			end
		end
		/ *
		* checkIfSubstringMatch() method checks is if subtext matches with text started from index i to the index last
		*
		* @test string original test
		* @subtext string original subtext
		* @i integer represent index of the text. The character of this index would by match with the first index character of the subtext
		* @last integer length of the subtext 
		* @boolean true if the subtext match from index i to index last otherwise false 
		*/
		def checkIfSubstringMatch(text, subtext, i, last)
			
			/ * temporary index - index cannot be changed, as it is object and it holds just reference*/
			tempIndex  = i;
			start = 0;
			while(start < last)
				/ *if its match, keep looping and increase indexes*/
				if(swapToLowerCase(text[tempIndex]) == swapToLowerCase(subtext[start]))
					tempIndex  = tempIndex + 1;
					start = start + 1;
				else
					/ * if it is not match return false. It is not point to loop any more*/
					return false;
				end
			end
			return true
		end
	/ *
	* swapToLowerCase() method swaps all English alphabetical character from upper case to lower case  
	* if different character is input then the method returns the same character 
	*
	* @letter string represent single character
	* @return string in a lower case or the same character
	*/
	def swapToLowerCase(letter)
		case letter
		when "A"
			return "a"
		when "B"
			return "b"
		when "C"
			return "c"
		when "D"
			return "d"
		when "E"
			return "e"
		when "F"
			return "f"
		when "G"
			return "g"
		when "H"
			return "h"
		when "I"
			return "i"
		when "J"
			return "j"
		when "K"
			return "k"
		when "L"
			return "l"
		when "M"
			return "m"
		when "N"
			return "n"
		when "O"
			return "o"
		when "P"
			return "p"
		when "Q"
			return "q"
		when "R"
			return "r"
		when "S"
			return "s"
		when "T"
			return "t"
		when "U"
			return "u"
		when "W"
			return "w"
		when "V"
			return "v"
		when "X"
			return "x"
		when "Y"
			return "y"
		when "Z"
			return "z"
		else 
			return letter
		end
	end
	/ *
	* len() method returns the length of the string
	* 
	* @param String any  test string 
	* @return integer (Fixnum) length of incoming string 
	*/
	def len(str)
		str = str.to_s()
		i = 0
		/ * loop until the end of the string and increase the index*/
		while(str[i].class == String)
			i = i + 1
		end
		return i
	end

end

/ *
* class MyMatch below assigns accessibility as private for the methods len(), 
* swapToLowerCase and checkIfSubstringMatch
*
*/
class MyMatch

	private :len
	private :swapToLowerCase
	private :checkIfSubstringMatch

end