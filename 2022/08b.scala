object Scala08b {
  class Tree(val height: Int, var scenic: Int) {
    override def toString: String = "(" + height + "," + scenic + ")"
  }
  object Tree {
    def fromChar(c: Char) = new Tree(c.asDigit, 1)
  }
  def watch(tree: Tree, line: Seq[Tree]): Int = {
    for ((t, idx) <- line.zipWithIndex) {
      if (t.height >= tree.height) {
        //println(tree + " in " + line + " =f " + (idx + 1))
        return idx + 1
      }
    }
    //println(tree + " in " + line + " =l " + line.length)
    line.length
  }
  def main(args: Array[String]) {
    val map = io.Source.stdin.getLines.map(_.toCharArray.map(Tree.fromChar(_)).toIndexedSeq).toIndexedSeq
    //for (line <- map)
    //  println(line.mkString(","))
    println("horizontal")
    for (line <- map) {
      for ((t, idx) <- line.zipWithIndex) {
        t.scenic *= watch(t, line.slice(idx + 1, line.length))
        t.scenic *= watch(t, line.reverse.slice(line.length - idx, line.length))
      }
    }
    println("vertical")
    for (line <- map.transpose) {
      for ((t, idx) <- line.zipWithIndex) {
        t.scenic *= watch(t, line.slice(idx + 1, line.length))
        t.scenic *= watch(t, line.reverse.slice(line.length - idx, line.length))
      }
    }
    for (line <- map)
      println(line.mkString(","))
    println("Best: " + map.map(_.maxBy(_.scenic)).maxBy(_.scenic))
  }
}
