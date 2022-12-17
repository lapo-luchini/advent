// this is my second Scala program ever
import scala.util.matching.Regex
object Scala05b {
  val re1: Regex = "(\\[[A-Z]\\]|   )( |$)".r
  val re2: Regex = "^move ([0-9]+) from ([0-9]+) to ([0-9]+)$".r
  def main(args: Array[String]) {
    var l: List[String] = List()
    var data = true
    for (ln <- io.Source.stdin.getLines) {
      println(ln)
      if (data) {
        // first we parse data
        var found = false
        for ((m, i) <- re1.findAllMatchIn(ln).zipWithIndex) {
          val g = m.group(1)
          if (g.charAt(0) != ' ') {
            while (l.length <= i)
              l = l :+ ""
            l = l.updated(i, l.apply(i) + g.charAt(1))
          }
          found = true
        }
        if (!found) {
          data = false
          println(l + " after parsing")
        }
      } else {
        // then we execute commands
        ln match {
          case re2(n, from, to) => {
            val iF = from.toInt - 1
            val iT = to.toInt - 1
            val iN = n.toInt
            val sF = l.apply(iF)
            val m = sF.substring(0, iN)
            l = l.updated(iF, sF.substring(iN))
            l = l.updated(iT, m + l.apply(iT))
          }
          case _ => 0
        }
        println(l)
      }
    }
    println("Result: " + l.map(s => s.charAt(0)).mkString)
  }
}
