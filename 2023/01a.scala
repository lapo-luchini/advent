object Scala2023_01a {
  def zero: Int = '0'
  def main(args: Array[String]) {
    var x = 0
    for (ln <- io.Source.stdin.getLines) {
      val n = ln.toList.filter(c=>c.isDigit)
      //println(n)
      //println((n(0) - zero) * 10 + n.reverse(0) - zero)
      x += (n(0) - zero) * 10 + n.reverse(0) - zero
    }
    println("Result: " + x)
  }
}
