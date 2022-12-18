import scala.collection.mutable.ListBuffer

object Scala01a {
  def main(args: Array[String]) {
    val elfs = io.Source.stdin.getLines.foldLeft(ListBuffer[Int](0)) {
      case (acc, "") => acc += 0
      case (acc, n) => acc.update(acc.length - 1, acc.last + n.toInt); acc // probably inefficient
    }
    println("Elfs: " + elfs)
    println("Max:  " + elfs.max)
    println("Top3: " + elfs.sortBy(-_).take(3).sum)
  }
}
