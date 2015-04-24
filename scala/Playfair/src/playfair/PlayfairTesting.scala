package playfair
/**
 * Class PlayfairTesting enable to test encode and decode methods by 
 * encoding and decoding text the were providing. Plain text
 * is passed through encode method and then compare if the encrypted text is 
 * the same as encrypted text that was providing.
 * In the same way is done with encoded text. Encoded text is passed through
 * decode method and then compare if the output text is the same 
 * with plain text that was providing.    
 *  
 *  
 * @author David Sajdl
 * @username dsajdl01
 * @version 14/02/2015
 */

object PlayfairTesting {
  
  def main(args: Array[String]): Unit = {
      // Providing keyword for encryption and decryption is Pennsylvania  
      val pl = new Coder("Pennsylvania")
      // plain text that was providing
      var text = "An anonymous reader sends word of a proof-of-concept Google Chrome browser extension that steals users' login details. The developer, Andreas Grech, says that he is trying to raise awareness about security among end users, and therefore chose Chrome as a test-bed because of its reputation as the safest browser."; 
      //print out result of encode method
      println("\nEccode text:")
      println(pl.encode(text))
      
      // result of the encode method
      var secretText = " fafaw aermw yqnvm vqyns genwm hwoln kqwow ofkpf nexcq wqfvp dckqu vhzwn ynmyz unsig wazcl wpxnv ipxey mpiqf asmvw lbvpx dymvd vaken obefm yinhq pdgyb npxfb zcsvp xzbas cxqki bynfn bonsn yniar wuynd tqbzp vowad sefxe ymnie fzcym ndqkp dfryn dckqu vinlw nyzlv mvyfl xenmg axpmy etwlx lwain zcnyf onyzl kqxny m"
      var decodeText = pl.decode(secretText)
      // print out result of decode method
      println("\nDecode text:")
      println(decodeText)
      
      
      // checking if the results of the methods are the same as the texts that were providing
      println("\nCheking if encode and decode methods produce right outcome:\n")
      // clearing out white spaces and all signs from providing plain text
      var excpText = pl.clearText(text) 
      decodeText = decodeText.replaceAll("\\s","")
      // original encrypted text that was providing 
      var originsecretText = "fafaw aermw yqnvm vqyns genwm hwoln kqwow ofkpf nexcq wqfvp dckqu vhzwn ynmyz unsig wazcl wpxnv ipxey mpiqf asmvw lbvpx dymvd vaken obefm yinhq pdgyb npxfb zcsvp xzbas cxqki bynfnbonsn yniar wuynd tqbzp vowad sefxe ymnie fzcym ndqkp dfryndckqu vinlw nyzlv mvyfl xenmg axpmy etwlx lwain zcnyf onyzlkqxny m"
      // clear original encrypted provided text and outcome text from encode method of white spaces
      originsecretText = originsecretText.replaceAll("\\s","")
      secretText = secretText.replaceAll("\\s", "")
      // printing out the result if both texts are the same
      println("1.) ENCODE, are the both secret text the same:  " + secretText.equals(originsecretText))
      println("2.) DECODE, are the both origin text the same:  " + decodeText.equals(excpText))
      
  }
  
}