use linalg.nu *
# export def linear [W: list<list<number>>, b: list<number>]: list<list<number>> -> list<list<number>> {
#   $in
#   | each {|row|
#       let dot_row = ($W | each {|col| (zip $row $col | each {|p| $p.0 * $p.1 } | math sum)})
#       (zip $dot_row $b | each {|p| $p.0 + $p.1 })
#     }
# }
