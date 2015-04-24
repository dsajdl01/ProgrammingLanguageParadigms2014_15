package playfair
 /**
 * Class Coder enables to encrypt and decrypt text known as 
 * a playfair cipher - symmetric encryption technique. 
 * 
 * Coder class has two master methods one is called encoder 
 * and second one is called decoder. Encoder methods 
 * produces encryption of the text where each row contains 
 * 10 blocks and each block has 5 characters.
 * Decoder method has two variety of produce outcome. 
 * First one is when the decrypted text was decrypt with 
 * method encoder. If decrypt text is produce by encoder 
 * with the same object then outcome is
 * as it was an original text only spaces and capital 
 * letters are not presented as was in the original text.
 * If decrypted text was not encrypt with encoder method 
 * or it was but with different object
 * then x and z letters are removed by probabilities 
 * and all j letters is presented as i
 *  
 *  
 * @author David Sajdl
 * @username dsajdl01
 * @version 14/02/2015
 */
class Coder (keyword: String) {
  private var playfair = scala.collection.mutable.Map[String,String]()
  private var isZAdded = false
  private var isEcodedtrue = false
  private var encodeTextlength = 0
  private var Jindex = scala.collection.immutable.IndexedSeq[AnyVal]()
  private var Xindex = scala.collection.immutable.IndexedSeq[AnyVal]()
  makeMap(getFillPlayfairKeyString(keyword))
  
  /**
   * getJIndex() method returns list of numbers that 
   * represent indexes of the j position in the plain text.
   * 
   * @return vector of integers that represent indexes of the j position from the plain text
   */
   def getJIndex(): scala.collection.immutable.IndexedSeq[AnyVal] = {
     return Jindex
   }
  /**
   * getIfZIsAdd() method returns true if the letter z is added at 
   * the end of the plain text string otherwise returns false
   * 
   * @return boolean true if letter z is added at the end of the string otherwise false
   */
   def getIfZIsAdd(): Boolean ={
     return isZAdded
   }
  /**
   * getXIndex() method returns list of numbers that represent 
   * indexes of the x position that are added into the plain text
   * 
   * @return vector of integers that represent indexes of the j position from the plain text
   */
   def getXIndex(): scala.collection.immutable.IndexedSeq[AnyVal] = {
     return Xindex
    }
   //--------------------------------------------------------------------------- 
   //------------------------------ DECODE METHOD ------------------------------
   //---------------------------------------------------------------------------
  /**
   * decode() method enables to decrypt text. The decrypted text contain either 
   * all letters in lower case as was the original plain text 
   * (this is only true if encryption is encrypted by method encode and with the same object) 
   * or if the encryption was not done with the same object then decrypted text
   * contain all letters in lower case where all j letters represent i letter, some x letter 
   * may be omitted and z letter may be deleted from the end of the text.     
   * 
   * @param string that represent encrypted text that will be decrypted
   * @return string that represent decrypt text
   */
   def decode(secretText: String): String ={
       val text = secretText.replaceAll("\\s","")
       val l = text.length()
       var output = ""
       var vec = getVector(text)
       for(i <- 0 until l by 2){output += getEncodeLetterBack(vec(i).toString(),vec(i+1).toString())}
       // get original letters to the text
       if(encodeTextlength == l && isEcodedtrue){
         output = removeXFromTextByArray(output)
         output = swapIforJ(output)
         output = removeZ(output)
       }
       else{ // get probability of x and z letters to the text
        output = removeXFromStringByPossibility(output) 
        output = removeZByProbability(output)
       }
       output = getRawAndColumns(output)
       return output
   }
  /**
   * removeZByProbability() method remove z letter from the text by probability
   * Method checks if letter z is at the end of the text. If yes then z letter 
   * is removed and text is return if z letter does not contain at the 
   * end of the string it return text back as was received.
   * 
   * @param string text that represent original text
   * @return string text that is either original text that it was 
   *                              received or text without z letter at the end 
   */
   def removeZByProbability(text: String): String = {
      if(text.substring(text.length()-1).equals("z")){
        return text.substring(0, text.length()- 1)
      }
      return text
    }
   /**
    * removeZ() method removes z letter from the text only if z letter was 
    * added to the text by the method checkIfOdd(), which is called from the encode() method.
    * 
    * @param String text that represent original text
    * @return String either original text as it was received or text without z letter at the end
    */
    def  removeZ(text: String): String ={
      if(isZAdded){
        return text.substring(0, text.length() - 1)
      }
      return text
    }
   /**
    * removeXFromTextByArray() method removes x letters from the string text
    * by comparing indexes of the text from the indexes stored in the vector list called Xindex. 
    * The vector list is fill with numbers (indexes) up inside addXbetweenDoubleLetters() 
    * method which is called from encode() method.
    *  
    * @param String text represent original text
    * @return String that is either original text as it was received or text where some x letters are deleted
    */
    def removeXFromTextByArray(text: String): String = {
      if(Xindex.size == 0){
        return text
      }
      var index = 0
      var output = ""
      for(i <- 0 until text.length() by 1){
        if(Xindex(index) == i){
          if (index < Xindex.size - 1){ index = index + 1}
        }
        else{ output = output + text.charAt(i)}
      }
      return output
   }
   /**
    * swapIforJ() method swaps some i letters back to j letters form the text
    * by comparing indexes of the text from the indexes stored in the vector list called Jindex.
    * The vector list is fill up with the numbers (indexes) inside swapjStringTextToi() 
    * method which is called from  encode() method.
    *  
    * @param String text that represent original text
    * @return String that is either original text as it was received or text where some x letters are deleted 
    */
    def swapIforJ(text: String): String ={
      if(Jindex.size == 0){
        return text;
      }
      var index = 0
      var output = ""
      for(i <- 0 until text.length() by 1){
        if(Jindex(index) == i){
          output += "j"
          if (index < Jindex.size - 1){ index = index + 1}
        }
        else{ output += text.charAt(i)
        }
      }
      return output
    }
   /**
    * removeXFromStringByPossibility() method removes x letters from the text by possibility.
    * When x letter appear between two the same letters e.g. lxl then x letter is removed
    *  
    * @param String text represent decrypted text
    * @return String that is either original text as it was received or text where some x letters are deleted 
    */
    def removeXFromStringByPossibility(text: String) : String = {
        val vex = getVector(text) 
        var output = vex(0).toString()
        for (i <- 1 until vex.size - 1 by 1){
              if((!(vex(i-1).equals(vex(i+1)))) || (!(vex(i).toString() == "x"))) {
                output = output + vex(i).toString()
              }
        }
        output = output + vex(vex.size-1).toString()
        return output
    }
   /**
    * getEncodeLetterBack() method swaps encrypted two letters back to original two letters
    *  
    *  @param String key1 that represent encrypted letter
    *  @param String key2 that represent encrypted letter
    *  @return String that represent two original letter   
    */
    def getEncodeLetterBack(key1: String, key2: String): String ={
        var keyVal1 = playfair.getOrElse(key1, null)
        var keyVal2 = playfair.getOrElse(key2, null)
        var newKeyVal1 = getDecodeNewValue(keyVal2, keyVal1)
        var newKeyVal2 = getDecodeNewValue(keyVal1, keyVal2)
        var outputKey1 = getKey(newKeyVal1)
        var outputKey2 = getKey(newKeyVal2)
        return outputKey1 + outputKey2 
    }
   /**
    * getDecodeNewValue() method is a main logic of swapping letters value of decode method. 
    * Two numbers that represent value of the letters are compare with each other. 
    * Each letters value (number) has two digits separate with comma. 
    * 
    * If the first digits of the first and second value are the same then 
    * second digit is decreased and return with the first digit of the 
    * first value, but if the second is one then it become five 
    * and return with the first digit of the first value.
    *  
    * If the second digits of the first and second value are the same then 
    * first digit is decreased and return with second digit of the first value, 
    * but if first digit has a value one then it become five and 
    * return with the second digit of the first value.
    * 
    * If none of the first and second digits are the same then from the first value is taken 
    * second digit and from the second value is taken first digit and return these two values.    
    *  
    * @param String key1 that represent letters value two digit of the encrypted letter
    * @param String key2 that represent letters value two digit of the encrypted letter
    * @return String that represent new (original) value of the first letter (or of key1)
    */
    def getDecodeNewValue(key1: String, key2: String) : String ={
           var arr1 = key1.split(",")
           var arr2 = key2.split(",")
           if(arr1(0)==arr2(0)){
                var num1: Int = arr1(1).toInt
                var num2: Int = arr2(1).toInt
                if(num2 == 1){ return together(arr1(0).toString() :: "5" :: Nil)}
                else{ num2 = num2 - 1
                      return together(arr1(0).toString() :: num2.toString() :: Nil)
                }
           }
           else if(arr1(1) == arr2(1)){
                var num1: Int = arr1(0).toInt
                var num2: Int = arr2(0).toInt
                if(num2 == 1){ return together("5" :: arr1(1).toString() :: Nil)}
                else{ num2 = num2 - 1
                      return together(num2.toString() :: arr1(1) :: Nil) 
                }
           }
           else{return together(arr2(0):: arr1(1) ::Nil)}
     }
    
    //------------------------------------------------------------------------------ 
    // ---------------------------- ENCODE METHOD ----------------------------------
    //------------------------------------------------------------------------------
   /**
    * encode() method enables to encrypt a text and return encrypted text. 
    * Firstly method sends text to be clear from the different signs 
    * and convert all letters into a lower case. Then method sends a message 
    * to swap j letter to i letter and save the positions of 
    * the j indexes into instance variable called Jindex. It also sends a message to 
    * insert x letter between two letters from the plain text. It also saves 
    * position of the insert x letters into vector instance variable called  
    * Xindex. If text has odd length then z letter is added at the end of the 
    * text to make it even and set instance variable called isZAdded to true. 
    * Then the method sends message to encrypt plain text and return encrypted text.  
    * 
    * @param string plainText that is a text that would be encrypted
    * @return string that represent encrypt text
    *  
    */
    def encode(plainText: String): String = {
        var newText = clearText(plainText)
        findIndexOfJ(newText)
        newText = swapjStringTextToi(newText)
        newText = addXbetweenDoubleLetters(newText)
        newText = checkIfOdd(newText)
        val list = getVector(newText)
        var output = ""
        for( i <-0 to list.size-2 by 2){output += getCode(list(i).toString(), list(i+1).toString())}
        encodeTextlength = output.length()
        output = getRawAndColumns(output)
        isEcodedtrue = true
        return output
    }
  /**
    * getRawAndColumns() method enables to format string into blocks 
    * and raws and return it back. Each block has five letters 
    * and each row has ten blocks 
    *  
    * @param string text that represent text without any white spaces
    * @return string that represent text which has five letters in one block and one raw has 10 block
    */
    def getRawAndColumns(text: String) : String ={
        val res = getVector(text)
        var output = " "
        var raw = 0
        var count = 0
        for(i <- 0 to res.size-1){
            // making block
            if(count == 5){
              count = 0
              output += " "
            }
            // making raw
            if(raw == 50){
                raw = 0
                output += "\n "
            }
            output += res(i)
            count = count + 1
            raw = raw + 1
        }
        return output
     }
   /**
    * getCode() method swaps two letters (from the plain text) 
    * to new letters (encrypt letters).
    *  
    * @param String key1 that represent one letter from the plain text
    * @param String key2 that represent one letter from the plain text
    * @return String that represent two encrypted letters   
    */
    def getCode(first: String, second: String): String ={
       val val1 = playfair.getOrElse(first, null)
       val val2 = playfair.getOrElse(second,null)
       val newVal1 = getNewValue(val1, val2)
       val newVal2 = getNewValue(val2, val1)
       val key1 = getKey(newVal1)
       val key2 = getKey(newVal2)
       return key1 + key2
    }
   /**
    * getKey() method searches through a map and gets key 
    * (single letter) from the letter's value
    * 
    * @param string value that represent letter's value e.g. 1,1
    * @return string that represent a single letter 
    */
    def getKey(value: String) : String = {
       playfair.keys.foreach{j=> if(playfair(j) == value){return j.toString()}}
       return null
    }
   /**
    * getNewValue() method is a main logic of swapping letter value
    * of encode method. Two numbers that represent value of the letters 
    * are compare with each other. Each letter value (number) has two 
    * digits separate with comma.
    * 
    * If the first digits of the first and second value are the same then second 
    * digit is increased, but if second digit is value 5 then it become 1
    * and then first digit of the first value and increase digit is return.
    * 
    * If second digit of the first and second value are the same then first 
    * digits are increased but the first digit is value 5 then it become 1 and
    * then the first digit of the first value and increase digit is return.
    * 
    * If none of the first and second digits are the same then from the first 
    * value is taken first digit and from the second value is taken second digit
    * and return these two digits.    
    *  
    * @param String key1 that represent letter's value
    * @param String key2 that represent letter's value
    * @return String that represent new (encrypted) value of the first letter's value (or of key1)
    */
    def getNewValue(val1: String, val2: String) : String ={
          val arr1 = val1.split(",")
          val arr2 = val2.split(",")
          if(arr1(0) == arr2(0)){
                var num1: Int = arr1(1).toInt
                var num2: Int = arr2(1).toInt
                if(num1 == 5){
                   return together(arr1(0).toString() :: "1" :: Nil)
                }
                else{
                   num1 = num1 + 1 
                   return together(arr1(0) :: num1.toString() :: Nil)
                }
          }else if(arr1(1) == arr2(1)){
                var num1: Int = arr1(0).toInt
                var num2: Int = arr2(0).toInt
                if(num1 == 5){return together("1" :: arr1(1).toString() :: Nil)}
                else{
                    num1 = num1 + 1
                    return together(num1.toString() :: arr1(1) :: Nil)}
          }else {
                return together(arr1(0) :: arr2(1) :: Nil)
          }
    }
   /**
    * together() method enables to concatenate two or more string list 
    * and return single string where each list value is separated with comma  
    * 
    * @param String list with any two of more values
    * @return String where each value of the list is separated by comma  
    */ 
    def together(strings: List[String]) = strings filter{_.nonEmpty} mkString ","
   /**
    * addXbetweenBoubleLeters() method searches through the plain text and when 
    * the pair of the same letters appears in the plain text, then x 
    * letter is added between two the same pair letters. 
    * 
    * @param String text that represent plain text that would be encoded 
    * @return String text where x letters are added between the same letters  
    */  
    def addXbetweenDoubleLetters(text: String): String ={
      var keyWord = text;
      var isDone = false;
      var xIndex = ""
      do{
              var newStr = ""
              isDone = false;
              var len = getLength(keyWord)
              for(i <- 0 to len by 2){
                  if(!isDone){
                      if(keyWord.length() % 2 != 0 && len < i+1){
                          newStr += keyWord.charAt(i).toString()
                      }
                      else if(keyWord.charAt(i) == keyWord.charAt(i+1)){
                          newStr += keyWord.charAt(i).toString() + "x" + keyWord.charAt(i+1).toString()
                          newStr += keyWord.substring(i+2)
                          xIndex += (i+1) + ","
                          isDone = true
                        
                      }
                      else{
                          newStr += keyWord.charAt(i).toString() + keyWord.charAt(i+1).toString()
                      } 
                  }
              }
              keyWord = newStr
          }while(isDone)
          if(!xIndex.equals("")){
            var arr = xIndex.split(",")
            Xindex = for(a <- 0 until arr.length) yield arr(a).toInt
          }
       return keyWord
    }
   /**
    * getLength() method checks length of the income text string and if the length is 
    * even method returns length - 2. If the length is odd then method return length - 1
    * 
    * @param String text that represent plain text that would be encoded 
    * @return Integer that is length - 2 if text is even else length - 1     
    */
    def getLength(text: String): Int ={
       var len = text.length();
       if(len % 2 == 0){
         return (len - 2)
       }
       else{
          return (len - 1)
       }
    }
   /**
    * chechIfOdd() method adds z letter at the end of the string only if the
    * length of the income text is odd
    * 
    * @param string text that represent plain text that would be encoded 
    * @return string text where z is added if the text is odd to make text even     
    */   
    def checkIfOdd(text: String) : String = {
      if(text.length() % 2 != 0){
        isZAdded = true
        return text + "z"
      }
      isZAdded = false
      return text
    }
   /**
    * clearText() method converts all letters into lower case letters
    * and remove all white spaces and signs from the text. If the text
    * contains numbers then the number is converted into words. 
    * 
    * @param string text that represent plain text that would be encoded 
    * @return string text that contains only alphabetical letters    
    */  
   def clearText(text: String): String = {
      var newText = text.toLowerCase().replaceAll("\\s","")
      var output = ""
      var vec = getVector(newText)
      for(i <- 0 until vec.size){
            output += matchTextForSign(vec(i).toString())
      }
      return output
    }
   /**
    * findIndexOfJ() method finds indexes of the j letter from the text and store the indexes 
    * (position) into vector instance variable called Jindex 
    * 
    * @param string text that represent plain text that would be encoded  
    */
  def findIndexOfJ(text: String) {
      var res = for (a <- 0 until text.length()) yield {if(text.charAt(a) == 'j')a}
      Jindex =  res.filter { x => x != () }
    }
  /**
    * swopjStringtextToi() method swaps all j letters from the text string 
    * to i letters    
    * 
    * @param string text that represent plain text that would be encoded 
    * @return string text where all j letters are replace with i letters  
    */ 
    def swapjStringTextToi(text: String) : String ={
      var output = ""
      for(i <- 0 until text.length() ){
        output += matchjCharToi(text.charAt(i))
      }
      return output
    }
   /**
    * matchjCharToi() method is a help method of the swapjStringTextToi() where
    * j letter is swap to i letter by matching the letters if the letter is j then i is return 
    * otherwise the same letter is returned  
    * 
    * @param char that represent any alphabetical letter 
    * @return string that represent a letter
    */    
    def matchjCharToi(x: Char): String = x match {
      case 'j' => "i"
      case _ => x.toString()
    }
   /**
    * matchTextForSign() method is a help method of the crearText() method where
    * all signs characters are deleted and numbers are converted into words. 
    * Method matches incoming single character with other characters and if 
    * incoming string contain sign method return empty string. If the 
    * incoming string contain number it returns word of the incoming number.
    * If the incoming string contain alphabetical letter it returns the same letter.
    * 
    * @param string that represent single letter, sign or number
    * @return string that is either alphabetical letter(s) or empty string 
    */ 
    def matchTextForSign(x: String): String = x match {
      case "!" => ""
      case "?" => ""
      case "_" => ""
      case " " => ""
      case "\n" => ""
      case "," => ""
      case "." => ""
      case "'" => ""
      case ":" => ""
      case ";" => ""
      case "-" => ""
      case "/" => ""
      case "\\" => ""
      case "@" => ""
      case "~" => ""
      case "#" => ""
      case "\"" => ""
      case "£" => ""
      case "$" => ""
      case "%" => "percentage"
      case "^" => ""
      case "&" => ""
      case "*" => ""
      case "(" => ""
      case ")" => ""
      case "=" => ""
      case "{" => ""
      case "}" => ""
      case "]" => ""
      case "[" => ""
      case "+" => ""
      case "1" => "one"
      case "2" => "two"
      case "3" => "three"
      case "4" => "four"
      case "5" => "five"
      case "6" => "six"
      case "7" => "seven"
      case "8" => "eight"
      case "9" => "nine"
      case "0" => "zero"
      case "|" => ""
      case ">" => ""
      case "<" => ""
      case "ÿ" => ""
      case "þ" => ""
      case _ => x.toString()
    }
    
    // ---------------------------------------------------------------------------------- 
    // ------------------ FILLING UP PLAYFAIR GRIDS WITH LETTERS ------------------------
    // ----------------------------------------------------------------------------------
   /**
    * makeMap() private method fills up playfair grids with letters. 
    * Each letter from the keyword is split up and fill in into the map. 
    * Each letter in the map has a unique value of two digits separate with a comma.  
    * 
    * @param string that contain keyword 
    */
    private def makeMap(keyWord: String){
        val a = keyWord.substring(0,1)
        val b = keyWord.substring(1,2)
        val c = keyWord.substring(2,3)
        val d = keyWord.substring(3,4)
        val e = keyWord.substring(4,5)
        
        val f = keyWord.substring(5,6)
        val g = keyWord.substring(6,7)
        val h = keyWord.substring(7,8)
        val i = keyWord.substring(8,9)
        val j = keyWord.substring(9,10)
        
        val k = keyWord.substring(10,11)
        val l = keyWord.substring(11,12)
        val m = keyWord.substring(12,13)
        val n = keyWord.substring(13,14)
        val o = keyWord.substring(14,15)
        
        val p = keyWord.substring(15,16)
        val q = keyWord.substring(16,17)
        val r = keyWord.substring(17,18)
        val s = keyWord.substring(18,19)
        val t = keyWord.substring(19,20)
        
        val u = keyWord.substring(20,21)
        val v = keyWord.substring(21,22)
        val w = keyWord.substring(22,23)
        val x = keyWord.substring(23,24)
        val y = keyWord.substring(24,25)
    
        playfair.+=(a -> "1,1", b -> "1,2", c -> "1,3", d -> "1,4", e ->"1,5",
                    f -> "2,1", g -> "2,2", h -> "2,3", i -> "2,4", j ->"2,5",
                    k -> "3,1", l -> "3,2", m -> "3,3", n -> "3,4", o ->"3,5",
                    p -> "4,1", q -> "4,2", r -> "4,3", s -> "4,4", t ->"4,5",
                    u -> "5,1", v -> "5,2", w -> "5,3", x -> "5,4", y ->"5,5")
    }
   /**
    * getFillPlayfairString() method enables to clear keyword string 
    * by using method clearText(). Then replace all j letters with i and 
    * add to the keyword string all alphabetical letters. 
    * Then method deletes all letters that already appears in the string 
    * by using distinct method so return it.
    * Return string has exactly 25 letters.  
    * 
    * @param string keyword that would be first word to fill up playfair grids
    * @return string that contain all alphabetical letters except j letter 
    *             and keyword is the first letters of the return string and then 
    *             the rest of the others alphabetical letters in acending order. 
    */     
    def getFillPlayfairKeyString(keyword: String): String ={
       var str = clearText(keyword) 
       str = str.replaceAll("j", "i")
       var letter = "abcdefghiklmnopqrstuvwxyz"
       str = str + letter
       return str.distinct
    }
   /**
    * getVector() method converts string into Vector list where each character
    * (index if the string) represent one value of the vector list.
    * 
    * @param string any text
    * @return vector character where each value of the list is a single letter (index) from the text string 
    */ 
    def getVector(text: String): scala.collection.immutable.IndexedSeq[AnyVal] ={
         return for(i <- 0 until text.length())  yield text.charAt(i)
    }
}