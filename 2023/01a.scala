object Scala2023_01a {
  def zero: Int = '0'
  def main(args: Array[String]) {
    var x = 0
    var l: List[String] = List()
    for (ln <- io.Source.stdin.getLines) {
      var n = ln.toList.filter(c=>c.isDigit)
      //println(n)
      //println((n(0) - zero) * 10 + n.reverse(0) - zero)
      x += (n(0) - zero) * 10 + n.reverse(0) - zero
    }
    println("Result: " + x)
  }
}
