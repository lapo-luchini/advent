object Scala2023_01b {
  def zero: Int = '0'
  def digits = Array("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
  def reDigits = digits.mkString("|").r
  def mapDigits = digits.zipWithIndex.toMap.view.mapValues(v => (v + 1).toString)
  def translate(s: String): String = {
    reDigits.replaceAllIn(s, m=>mapDigits(m.matched))
  }
  def main(args: Array[String]) {
    var x = 0
    for (ln <- io.Source.stdin.getLines) {
      val n = translate(ln).toList.filter(c => c.isDigit)
      val v = (n(0) - zero) * 10 + n.reverse(0) - zero
      println(ln + "=" + v)
      x += v
    }
    println("Result: " + x)
  }
}
