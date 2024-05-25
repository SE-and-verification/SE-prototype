package aes

object Params {
  val Nb: Int = 4 // columns in state (in this standard)
  val rows: Int = 4
  val StateLength: Int = Nb * rows //CONFUSION
  val new_integrity_length: Int = 16 // Added by Yishen Zhou, temporarily hard-coded, 05/24/2024
  val CiphLength: Int = 32
}
