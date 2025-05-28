export def dot [right: list<number>]: list<number> -> number {
  $in
  | zip $right
  | each {|pair| $pair.0 * $pair.1 }
  | math sum
}
