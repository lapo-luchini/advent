object Scala08a {
  class Tree(val height: Int, var visible: Boolean)
  object Tree {
    def fromChar(c: Char) = new Tree(c.asDigit, false)
  }
  def watch(line: List[Tree]): Unit = {
    var max = -1
    for (t <- line) {
      if (t.height > max) {
        max = t.height
        t.visible = true
      }
    }
  }
  def main(args: Array[String]) {
    val map = io.Source.stdin.getLines.map(_.toCharArray.map(Tree.fromChar(_)).toList).toList
    for (line <- map) {
      watch(line)
      watch(line.reverse)
    }
    for (line <- map.transpose) {
      watch(line)
      watch(line.reverse)
    }
    println("Visible: " + map.map(_.count(_.visible)).sum)
  }
}
