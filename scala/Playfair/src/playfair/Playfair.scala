package playfair
import java.io.File;
import javax.swing.JFileChooser
 /**
 * Class Playfair enable to encrypt and dercypt files. 
 * Playfair Class asking if the user wants to encode, decode file or to quite.
 * If encode file is chosen then user is asked to input keyword and then to select a file
 * inside pop up dialog box. If the file is selected and button 'open' is pressed, 
 * then content of the file will be encrypted and print it out. 
 * Then user will be ask if the user wants to encode, decode file or quit again until quit is chosen. 
 * 
 * If file is not selected it will print out 'No file was selected' and 
 * user will be ask if the user wants to encode, decode file or quit again.
 * 
 * if the decode file would be chosen if follows the same steps as it is in encode file only it will print decoded file.
 * 
 * If quit is chosen then method prints good-bye and terminate method.
 *  
 *  
 * @author David Sajdl
 * @username dsajdl01
 * @version 14/02/2015
 */
object Playfair {
  def main(args: Array[String]): Unit = {
      var toContinue = true 
      // do job until quit is chosen (toContinue is false) 
      while(toContinue){
          try{
              // displaying message to make a choice
              println("Scala rocket playfair!")
              println("Do you want to encode file, decode file or quit.")
              println("For encode file press 1")
              println("For decode file press 2")
              println("For quit press any kye on the keyboard")
              print("Please your entry : ")
              var str =  Console.readLine()
              // if encode file is chosen
              if(str.equals("1")){
                  // displaying message to enter keyword
                   print("Please enter your keyword: ")
                   val keyword =  Console.readLine()
                   val pl = new Coder(keyword);
                   // popping up a dialog box to choose any file
                   var path = getPath("Select file to be encoded")
                   if(path != null){
                       val lines = scala.io.Source.fromFile(path).mkString
                       println("\nYOUR ENCODE TEXT:")
                       // print encode content of the file out
                       println(pl.encode(lines))
                   }
              // if decode file is chosen
              }else if(str.equals("2")){
                   // displaying message to enter a keyword
                   print("Please enter your keyword: ")
                   val keyword =  Console.readLine()
                   val pl = new Coder(keyword);
                   // popping up dialog box to choose a file
                   var path = getPath("Select file to be decoded")
                   if(path != null){
                       val line = scala.io.Source.fromFile(path).mkString                
                       println("\nYOUR DECODE TEXT:")
                       // print decode content of the file out
                       println(pl.decode(line))
                   }
              // if quit is chosen     
              }else{
                   toContinue = false
                   println("\n GOOD-BYE")
              }
          }
          // deal with errors e.g file is not found
          catch{
            case e: Exception => println("Sorry the error has occure:\n" + e)
          }
          println("\n")
        }
     }
     /**
      * getPath() private method is a helping method to the maim method
      * Method opens dialog box where the users can choose a file and 
      * then press 'open' button and method will return a path to the 
      * particular file. If the users press a cancel button
      * then method print "No file was selected" out and return null.
      *    
      *@param string message which represent a title of the dialog box
      *@return string which represent path to the selected file.
      */
     private def getPath(message: String): String ={
       var choose = new JFileChooser();
       choose.setCurrentDirectory(new java.io.File("."));
       choose.setDialogTitle(message);
       choose.setAcceptAllFileFilterUsed(true);
       if(choose.showOpenDialog(null) == JFileChooser.APPROVE_OPTION){
           return choose.getSelectedFile().toString();
       }
       println("No file was selected")
       return null
     }
  
}