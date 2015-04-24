package playfair
import org.scalatest.junit.AssertionsForJUnit
import scala.collection.mutable.ListBuffer
import org.junit.Assert._
import org.junit.Test
import org.junit.Before
import org.junit.After
 /**
 * Class TestCoder enables to make a unit testing on all methods from the class Coder.
 *  
 * @author David Sajdl
 * @username dsajdl01
 * @version 14/02/2015
 */

class TestCoder extends AssertionsForJUnit{
    // declare instance variables
    var pl: Coder =_
    val keyword: String = "Pennsylvania"
    val strWithX1: String = "telxlingsmallxlies"
    val strWithoutX1: String =  "tellingsmalllies"
    val strWithX2: String = "makingwordshard"
    val strWithoutX2: String ="makingwordshard"
    val strWithX3: String ="arraywithyyxyxyxyxyxyandyxyxyxy"
    val strWithoutX3: String ="arraywithyyyyyyyandyyyy"
  
  /**
   * initialize() method is called before that any method in the testCoder is executed   
   */
   @Before def initialize(){
     pl = new Coder(keyword)
   }
  /**
   * tearDown() method is called after all methods in the TestCoder are executed   
   */
   @After def tearDown(){
      pl = null
   }
  /**
   * test_getXIndex() method is testing getXIndex() method
   */
   @Test def test_getXIndex(){
      var vec1 = Vector()
      pl.addXbetweenDoubleLetters(strWithoutX2)
      assertEquals(vec1, pl.getXIndex())
      var vec2 = Vector(3,13)
      pl.addXbetweenDoubleLetters(strWithoutX1)
      assertEquals(vec2, pl.getXIndex())
       var vec3 = Vector(11,13,15,17,19,25,27,29)
      pl.addXbetweenDoubleLetters(strWithoutX3)
      assertEquals(vec3, pl.getXIndex())
   }
  /**
   * test_getFillPlayfaireString() method is testing getFillPlayfaireString() method
   */
   @Test def test_getFillPlayfaireKeyString(){
      val output = "pensylvaibcdfghkmoqrtuwxz"
      val wrong_output = "pensylvajbcdfghkmoqrtuwxz"
      val keyword1 = "david.Sajdl/+=26%"
      val output1 = "davisltwoxpercngbfhkmquyz"
      assertEquals(output,pl.getFillPlayfairKeyString(keyword))
      assertEquals(25,pl.getFillPlayfairKeyString(keyword).length())
      assertNotEquals(wrong_output, pl.getFillPlayfairKeyString(keyword))
      assertEquals(output1,pl.getFillPlayfairKeyString(keyword1))
      assertEquals(25,pl.getFillPlayfairKeyString(keyword1).length())
   }
  /**
   * test_getVector() method is testing getVextor() method
   */
   @Test def test_getVector(){
      val vect = Vector('P','e','n','n','s','y','l','v','a','n','i','a')
      assertEquals(vect, pl.getVector(keyword))
      val vect2 = Vector('d','a','v','i','d')
      assertEquals(vect2, pl.getVector("david"))
   }
  /**
   * test_matchtextForSign() method is testing matchTestForSign() method
   */
   @Test def test_matchtextForSign(){
       assertEquals("", pl.matchTextForSign("'"))
       assertEquals("b", pl.matchTextForSign("b"))
       assertEquals("one", pl.matchTextForSign("1"))
       assertEquals("", pl.matchTextForSign("&"))
       assertEquals("g", pl.matchTextForSign("g"))
       assertEquals("", pl.matchTextForSign("\\"))
       assertEquals("", pl.matchTextForSign("\""))
       assertEquals("eight", pl.matchTextForSign("8"))
   }
  /**
   * test_matchjCharToi() method is testing matchjCharToi() method
   */
   @Test def test_matchjCharToj(){ 
       assertEquals("i", pl.matchjCharToi('j'))
       assertEquals("i", pl.matchjCharToi('i'))
       assertEquals("c", pl.matchjCharToi('c'))
   }
  /**
   * test_swapjStringTextToi() method is testing swapjStringTextToi() method
   */
   @Test def test_swapjStringTextToi(){
      assertEquals("haii", pl.swapjStringTextToi("hajj"))
      assertEquals("enioyieans", pl.swapjStringTextToi("enjoyjeans"))
      assertEquals("fred", pl.swapjStringTextToi("fred"))
   }
  /**
   * test_findIndexOfJ() method is testing findIndexOfJ() method
   */
   @Test def test_findIndexOfJ(){
      pl.findIndexOfJ("enjoyjeans")
      val vec =  Vector(2,5)
      assertEquals(vec,pl.getJIndex())
      val vec1 = Vector()
      pl.findIndexOfJ("fredsmith")
      assertEquals(vec1, pl.getJIndex())
   }
  /**
   * test_clearText() method is testing clearText() method
   */
   @Test def test_clearText(){
      assertEquals("pricethreethree",pl.clearText("{[p*r(i)c*e£3.3,]}"))
      assertEquals("woowfivepercentage",pl.clearText("!w£$^&*(++=o==@/\\//o~#w...5...%........."))
   }
  /**
   * test_checkIfOdd() method is testing checkIfOdd() method
   */
   @Test def test_checkIfOdd(){
      pl.checkIfOdd("david")
      assertTrue(pl.getIfZIsAdd())
      pl.checkIfOdd("fred")
      assertFalse(pl.getIfZIsAdd())
   }
  /**
   * test_getLength() method is testing getLength() method
   */
   @Test def test_getLength(){
      assertEquals(8,pl.getLength("davidsajdl"))
      assertEquals(8,pl.getLength("davesajdl"))
      assertEquals(32,pl.getLength("wowthisisgreatasicanwritescalacode"))
   }
  /**
   * test_addXbetweenDoubleLerrets() method is testing addXbetweenDoubleLerrets() method
   */
  @Test def test_addXbetweenDoubleLerrets(){
      assertEquals(strWithX1,pl.addXbetweenDoubleLetters(strWithoutX1))
      assertEquals(strWithX2,pl.addXbetweenDoubleLetters(strWithoutX2))
      assertEquals(strWithX3,pl.addXbetweenDoubleLetters(strWithoutX3))
   }
  /**
   * test_together() method is testing together() method
   */
   @Test def test_together(){
      assertEquals("wow,this,should,be,concatinated,together,in,one,string,seperate,with,commma",pl.together("wow"::"this"::"should"::"be"::"concatinated"::"together"::"in"::"one"::"string":: "seperate"::"with"::"commma" :: Nil))
      assertEquals("1,3",pl.together("1"::"3"::Nil))
   }
  /**
   * test_getNewValue() method is testing getNewValue() method
   *
   * grid that represent letters value as key:
   *    1,1|1,2|1,3|1,4|1,5
   *    2,1|2,2|2,3|2,4|2,5
   *    3,1|3,2|3,3|3,4|3,5
   *    4,1|4,2|4,3|4,4|4,5
   *    5,1|5,2|5,3|5,4|5,5
   */
   @Test def test_getNewValue(){
      assertEquals("2,3",pl.getNewValue("2,2", "2,4"))
      assertEquals("2,5",pl.getNewValue("2,4", "2,2"))
      assertEquals("2,1",pl.getNewValue("2,5", "2,4"))
      
      assertEquals("3,3",pl.getNewValue("2,3", "4,3"))
      assertEquals("5,3",pl.getNewValue("4,3", "2,3"))
      assertEquals("1,3",pl.getNewValue("5,3", "1,3"))
      
      assertEquals("2,3",pl.getNewValue("2,2", "4,3"))
      assertEquals("4,2",pl.getNewValue("4,3", "2,2"))
      assertEquals("1,1",pl.getNewValue("1,5", "5,1"))
      assertEquals("5,5",pl.getNewValue("5,1", "1,5"))
   }
  /**
   * test_getKey() method is testing getKye() method
   *
   *  letters as value and their number as key;
   * Val:  p   e   n   s   y      l   v   a   i   b        
   * Key: 1,1|1,2|1,3|1,4|1,5 |*| 2,1|2,2|2,3|2,4|2,5  
   * Val:  c   d   f   g   h       k   m   o   q   r       
   * Key: 3,1|3,2|3,3|3,4|3,5 |*| 4,1|4,2|4,3|4,4|4,5 
   * Val:   t   u   w   x   z
   * Key:  5,1|5,2|5,3|5,4|5,5
   */
   @Test def test_getKey(){
     assertEquals("n",pl.getKey("1,3"))
     assertEquals("i",pl.getKey("2,4"))
     assertEquals("h",pl.getKey("3,5"))
     assertEquals("k",pl.getKey("4,1"))
     assertEquals("w",pl.getKey("5,3"))
     assertEquals("z",pl.getKey("5,5"))
     assertEquals(null,pl.getKey("ale"))
   }
   /**
   * test_getCode() method is testing getCode() method
   *
   *  grid fill in with letters of the keyword Pennsylvania
   *    1 2 3 4 5
   *  1 p|e|n|s|y
   *  2 l|v|a|i|b
   *  3 c|d|f|g|h
   *  4 k|m|o|q|r
   *  5 t|u|w|x|z
   */ 
   @Test def test_getCode(){
     assertEquals("em",pl.getCode("u", "d"))
     assertEquals("fw",pl.getCode("a", "o"))
     assertEquals("yb",pl.getCode("z", "y"))
     assertEquals("ab",pl.getCode("v", "i"))
     assertEquals("rk",pl.getCode("q", "r"))
     assertEquals("tu",pl.getCode("z", "t"))
     
     assertEquals("gm",pl.getCode("d", "q"))
     assertEquals("mg",pl.getCode("q", "d"))
     assertEquals("zp",pl.getCode("t", "y"))
     assertEquals("pz",pl.getCode("y", "t"))
     assertEquals("gt",pl.getCode("c", "x"))
     assertEquals("vn",pl.getCode("a", "e"))
   }
   /**
   * test_getRowAndColumns() method is testing getRowAndColumns() method
   */
   @Test def test_getRowAndColumns(){
       assertEquals(" david sajdl isget tingt ired",pl.getRawAndColumns("davidsajdlisgettingtired"))
       assertEquals(" david sajdl justt hinki ngwho shoul dgets olong sente nceto \n satis fycon ditio nofth is",pl.getRawAndColumns("davidsajdljustthinkingwhoshouldgetsolongsentencetosatisfyconditionofthis"))
   }
  /**
   * test_encoder() method is testing encoder() method
   */
   @Test def test_encoder(){
       assertEquals(" dyita knwmh",pl.encode("hello word"))
       assertEquals(" upitv bsfeq ivitv bny",pl.encode(strWithoutX1))
       assertEquals(" fvabg eibcv unpwo wqzob upfaf cnuin upitv bsfwk vdymb hmfsb \n pvgio vitvb fawai wobup yx",pl.encode("David Sajdl went for x-rate and he was telling to everybody jeli small Jano na x-rates"))
    }
   
  /**
   * test_getDecodedNewvalue() method is testing getDecodedNewvalue() method
   *
   * grid with letter's value as a key:
   *  1,1|1,2|1,3|1,4|1,5
   *  2,1|2,2|2,3|2,4|2,5
   *  3,1|3,2|3,3|3,4|3,5
   *  4,1|4,2|4,3|4,4|4,5
   *  5,1|5,2|5,3|5,4|5,5
   * 
   */
   @Test def test_getDecodedNewvalue(){
      assertEquals("4,3", pl.getDecodeNewValue("4,2", "4,4"))
      assertEquals("4,1", pl.getDecodeNewValue("4,4", "4,2"))
      assertEquals("2,5", pl.getDecodeNewValue("2,5", "2,1"))
      assertEquals("2,4", pl.getDecodeNewValue("2,1", "2,5"))
      
      assertEquals("3,3", pl.getDecodeNewValue("2,3", "4,3"))
      assertEquals("1,3", pl.getDecodeNewValue("4,3", "2,3"))
      assertEquals("4,5", pl.getDecodeNewValue("1,5", "5,5"))
      assertEquals("5,5", pl.getDecodeNewValue("5,5", "1,5"))
      
      assertEquals("3,3", pl.getDecodeNewValue("2,3", "3,5"))
      assertEquals("2,5", pl.getDecodeNewValue("3,5", "2,3"))
      assertEquals("1,5", pl.getDecodeNewValue("5,5", "1,1"))
      assertEquals("5,1", pl.getDecodeNewValue("1,1", "5,5"))
   }
 /**
   * test_getEncodeLetterBack() method is testing getEncodeLetterBack() method
   *  
   *  grid fill up with letters of the keyword Pennsylvania
   *    1 2 3 4 5
   *  1 p|e|n|s|y
   *  2 l|v|a|i|b
   *  3 c|d|f|g|h
   *  4 k|m|o|q|r
   *  5 t|u|w|x|z
   */
   @Test def test_getEncodeLetterBack(){
      assertEquals("lv", pl.getEncodeLetterBack("v", "a"))
      assertEquals("hg", pl.getEncodeLetterBack("c", "h"))
      assertEquals("ro", pl.getEncodeLetterBack("k", "q"))
      
      assertEquals("pc", pl.getEncodeLetterBack("l", "k"))
      assertEquals("wo", pl.getEncodeLetterBack("n", "w"))
      assertEquals("zb", pl.getEncodeLetterBack("y", "h"))
      
      assertEquals("gu", pl.getEncodeLetterBack("d", "x"))
      assertEquals("qv", pl.getEncodeLetterBack("m", "i"))
      assertEquals("yt", pl.getEncodeLetterBack("p", "z"))
   }
  /**
   * test_removeXFromStringByPossibility() method is testing removeXFromStringPossibility() method
   */
   @Test def test_removeXFromStringByPossibility(){
      assertEquals(strWithoutX1, pl.removeXFromStringByPossibility(strWithX1))
      assertEquals(strWithoutX2, pl.removeXFromStringByPossibility(strWithX2))
      assertEquals(strWithoutX3, pl.removeXFromStringByPossibility(strWithX3))
      assertEquals("davidsajdlwentforrateadhewastellingtoeverybody",pl.removeXFromStringByPossibility("davidsajdlwentforxrateadhewastelxlingtoeverybody"))
   }
  /**
   * test_removeXFromTextByArray() method is testing removeXFromTextByArray() method
   * 
   * the different between methods removeXFromStringByPossibility() and removeXFromTextByArray() is
   * if there is a sentence such as: "went for x rate" where x should not be removed, 
   * by using method removeXFromStringByPossibility() x letter would be removed as
   * x letter appears between 2 same letters 'r'.
   * On the other hand, if removeXFromTextByArray() method is used x letter would stay.
   *
   */
   @Test def test_removeXFromTextByArray(){
        pl.addXbetweenDoubleLetters(strWithoutX2)
        assertEquals(strWithoutX2, pl.removeXFromTextByArray(strWithX2))
        val pl1 = new Coder(keyword)
        pl1.addXbetweenDoubleLetters(strWithoutX3)
        assertEquals(strWithoutX3, pl1.removeXFromTextByArray(strWithX3))
        val pl2 = new Coder(keyword)
        pl2.addXbetweenDoubleLetters("davidsajdlwentforxrateadhewastellingtoeverybody")
        assertEquals("davidsajdlwentforxrateadhewastellingtoeverybody", pl2.removeXFromTextByArray("davidsajdlwentforxrateadhewastellingtoeverybody"))
   } 
  /**
   * test_swapIfoprJ() method is testing swapIfoprJ() method
   */
  @Test def test_swapIfoprJ(){
      pl.findIndexOfJ("hajj")
      assertEquals("hajj", pl.swapIforJ(("haii")))
      pl.findIndexOfJ("enjoyjeans")
      assertEquals("enjoyjeans", pl.swapIforJ("enioyieans"))
      pl.findIndexOfJ("davidsajdlenjoyview")
      assertEquals("davidsajdlenjoyview", pl.swapIforJ("davidsaidlenioyview"))
   }
  /**
   * test_removeZ() method is testing removeZ() method
   */
   @Test def test_removeZ(){
      pl.checkIfOdd("david")
      assertTrue(pl.getIfZIsAdd())
      assertEquals("david", pl.removeZ("davidz"))
      val s = "quiz"
      pl.checkIfOdd(s)
      assertFalse(pl.getIfZIsAdd())
      assertEquals(s,pl.removeZ(s))
   }
  /**
   * test_removeZByProbability() method is testing removeZByProbability() method.
   * 
   * Different between removeZ() and removeZByProbability() methods are that 
   * if there is word like: 'quiz' where z letter should not be removed by using 
   * removeZByProbability() method is just checked if letter z appears at the end of the string
   * if yes, letter z is removed so method returns "qui". On the other hand, by using removeZ() method 
   * where method properly check if z letter is added to the end of the string, 
   * and if yes, z letter is remover, if not it returns string back. So into word 'quiz' 
   * z letter is not added by method checkIfOdd() therefore method removeZ() returns 'quiz'  
   *
   */
   @Test def test_removeZByProbability(){
      assertEquals("david", pl.removeZByProbability("david"))
      assertEquals("david",pl.removeZByProbability("davidz"))
      assertEquals("qui", pl.removeZByProbability("quiz"))
   }
  /**
   * test_decode() method is testing decode() method
   */
   @Test def test_decode(){
       pl.encode("hello word")
       assertEquals(" hello word",pl.decode(" dyita knwmh"))
       pl.encode(strWithoutX1)
       assertEquals(" telli ngsma lllie s", pl.decode("upitv bsfeq ivitv bny"))
       pl.encode("David Sajdl went for x-rate and he was telling to everybody jeli small Jano na x-rates")
       assertEquals(" david sajdl wentf orxra teand hewas telli ngtoe veryb odyje \n lisma lljan onaxr ates", pl.decode(" fvabg eibcv unpwo wqzob upfaf cnuin upitv bsfwk vdymb hmfsb pvgio vitvb fawai wobup yx"))
   }
}