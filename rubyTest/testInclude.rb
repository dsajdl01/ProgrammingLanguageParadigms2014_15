/
* Class MyMatch enable to match the subtext against the text 
* co
* @author David Sajdl
* @version 27-08-2015
*
* /

class MyMatch
		/ * constructor /
		def initialize()
		end
		/
		* get_match_subString() method matchs the subtext against the text 
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
			last = subtext.length
			if(last == 0 || text.length < last)
				return "<no matches>"
			end
			/ * declaring variables and assigning values */
			index = 0
			i = 0
			found = false
			result = []
			/ *  loop through the text by using substring and compare whether it's equal to substring */
			while (index < text.length - last + 1)
				if(text[index,last].downcase == subtext.downcase)
					/ * if they are qeual then store position into array and assign found bariable to true */
					found = true
					position = index + 1
					#puts text[index,last] + " in position: " + position.to_s() 
					result[i] = position
					i = i + 1
				end
				index = index + 1
			end
			/ * return correct result */
			if(!found)
				return "<no matches>"
			else
				return result
			end
		end
end